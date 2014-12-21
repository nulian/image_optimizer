require "image_optimizer/base"

class ImageOptimizer
  class JPEGOptimizer < Base
    attr_reader :path, :options

    def initialize(path, options = {})
      @path = path
      @options = options
      @name = 'convert'
    end

    def optimize
      return unless jpeg_format?

      if jpeg_optimizer_present?
        optimize_jpeg
      else
        warn 'Attempting to optimize a jpeg without image magick installed. Skipping...'
      end
    end

    private

    def jpeg_format?
      ['jpeg', 'jpg'].include? extension(path)
    end

    def extension(path)
      path.split('.').last.downcase
    end

    def optimize_jpeg
      success = false
      Tempfile.open(filename) do |in_file|
        in_file.binmode
        in_file.write IO.binread(path)
        in_file.close
        success = system(jpeg_optimizer_bin + ' ' + command_options(in_file.path))
      end
      success
    end

    def command_options(temp_path)
      flags = ['-strip','-interlace Plane']
      flags << max_quantity if (0..100).include?(options[:quality])
      flags << quiet if options[:quiet]
      flags << temp_path
      flags << path
      flags.join(' ')
    end

    def max_quantity
      "-quality #{options[:quality]}"
    end

    def filename
      path.split('/').last
    end

    def quiet
      '-quiet'
    end

    def jpeg_optimizer_present?
      !jpeg_optimizer_bin.nil? && !jpeg_optimizer_bin.empty?
    end

    def jpeg_optimizer_bin
      @jpeg_optimizer_bin ||= binary_path
    end

  end
end
