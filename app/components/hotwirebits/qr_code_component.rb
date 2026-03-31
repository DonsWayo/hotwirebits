# frozen_string_literal: true

module HotwireBits
  class QrCodeComponent < Base
    def initialize(value:, size: 200, margin: 4, **attrs)
      @value = value
      @size = size
      @margin = margin
      @extra_attrs = attrs
    end

    def modules
      encode_qr(@value)
    end

    private

    def encode_qr(data)
      # Simplified QR encoding using byte mode, version 2 (25x25)
      # Uses a numeric/alphanumeric detection then byte fallback
      version = determine_version(data.bytesize)
      size = 17 + version * 4
      matrix = Array.new(size) { Array.new(size, 0) }
      reserved = Array.new(size) { Array.new(size, false) }

      place_finder_patterns(matrix, reserved, size)
      place_timing_patterns(matrix, reserved, size)
      place_alignment_patterns(matrix, reserved, version) if version >= 2
      place_dark_module(matrix, reserved)

      data_bits = encode_data(data, version)
      place_data(matrix, reserved, data_bits, size)

      apply_best_mask(matrix, reserved, size)

      place_format_info(matrix, reserved, size, 0)

      matrix
    end

    def determine_version(byte_len)
      return 1 if byte_len <= 17
      return 2 if byte_len <= 32
      return 3 if byte_len <= 53

      4
    end

    def place_finder_patterns(matrix, reserved, size)
      positions = [[0, 0], [0, size - 7], [size - 7, 0]]
      positions.each do |r, c|
        7.times do |i|
          7.times do |j|
            on_edge = [0, 6].include?(i) || j == 0 || j == 6
            in_center = i.between?(2, 4) && j.between?(2, 4)
            matrix[r + i][c + j] = (on_edge || in_center) ? 1 : 0
            reserved[r + i][c + j] = true
          end
        end
      end
    end

    def place_timing_patterns(matrix, reserved, size)
      (8...size - 8).each do |i|
        unless reserved[6][i]
          matrix[6][i] = i.even? ? 1 : 0
          reserved[6][i] = true
        end
        unless reserved[i][6]
          matrix[i][6] = i.even? ? 1 : 0
          reserved[i][6] = true
        end
      end
    end

    def place_alignment_patterns(matrix, reserved, version)
      return if version < 2

      positions = alignment_positions(version)
      positions.each do |r|
        positions.each do |c|
          next if reserved[r][c]

          (-2..2).each do |dr|
            (-2..2).each do |dc|
              on_edge = dr.abs == 2 || dc.abs == 2
              center = dr == 0 && dc == 0
              matrix[r + dr][c + dc] = (on_edge || center) ? 1 : 0
              reserved[r + dr][c + dc] = true
            end
          end
        end
      end
    end

    def alignment_positions(version)
      return [6, 18] if version == 2
      return [6, 22] if version == 3

      [6, 26] if version == 4
    end

    def place_dark_module(matrix, reserved)
      matrix[-8][8] = 1
      reserved[matrix.size - 8][8] = true
    end

    def encode_data(data, version)
      bits = "0100" # byte mode indicator
      char_count = data.bytesize
      cc_bits = (version <= 9) ? 8 : 16
      bits += char_count.to_s(2).rjust(cc_bits, "0")
      data.each_byte { |b| bits += b.to_s(2).rjust(8, "0") }
      cap = data_capacity(version)
      bits += "0" until bits.size >= cap || bits.size % 8 == 0
      pad_bytes = %w[11101100 00010001]
      pi = 0
      bits += pad_bytes[pi % 2] while bits.size < cap && (pi += 1)
      bits
    end

    def data_capacity(version)
      [128, 224, 352, 512][version - 1]
    end

    def place_data(matrix, reserved, bits, size)
      bit_idx = 0
      upward = true
      (size - 1).step(1, -2) do |col|
        col -= 1 if col == 6
        size.times do |i|
          r = upward ? (size - 1 - i) : i
          [col, col - 1].each do |c|
            next if reserved[r][c]

            matrix[r][c] = (bit_idx < bits.size && bits[bit_idx] == "1") ? 1 : 0
            bit_idx += 1
          end
        end
        upward = !upward
      end
    end

    def apply_best_mask(matrix, reserved, size)
      mask = ->(r, c) { (r + c).even? }
      size.times do |r|
        size.times do |c|
          next if reserved[r][c]

          matrix[r][c] ^= 1 if mask.call(r, c)
        end
      end
    end

    def place_format_info(matrix, _reserved, size, _mask_pattern)
      format_bits = "011010101011100"
      coords1 = (0..5).to_a + [7, 8]
      coords2 = (0..7).reverse_each.to_a
      coords1.each_with_index do |i, j|
        matrix[8][i] = (format_bits[j] == "1") ? 1 : 0
        matrix[i][8] = begin
          (format_bits[j + 7] == "1") ? 1 : 0
        rescue
          nil
        end
      end
      coords2.each_with_index do |i, j|
        matrix[size - 1 - i][8] = (format_bits[j] == "1") ? 1 : 0
        matrix[8][size - 1 - i] = begin
          (format_bits[j + 7] == "1") ? 1 : 0
        rescue
          nil
        end
      end
    end
  end
end
