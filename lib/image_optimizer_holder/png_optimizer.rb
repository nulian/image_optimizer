require "image_optimizer_holder/base"

class ImageOptimizerHolder
  class PNGOptimizer < Base
    attr_reader :path, :options

    def initialize(path, options = {})
      @path = path
      @options = options
      @name = 'pngcrush'
    end

    def optimize
      return unless png_format?

      if png_optimizer_present?
        optimize_png
      else
        warn 'Attempting to optimize a png without pngcrush installed. Skipping...'
      end
    end

  private

    def png_format?
      ['png'].include? extension(path)
    end

    def extension(path)
      path.split('.').last.downcase
    end

    def optimize_png
      success = false
      Tempfile.open(filename) do |in_file|
        in_file.binmode
        in_file.write IO.binread(path)
        in_file.close
        success = system(png_optimizer_bin, *command_options(in_file.path))
      end
      success
    end

    def command_options(temp_path)
      flags = ['-rem alla', '-rem text']
      flags << quiet if options[:quiet]
      flags << temp_path
      flags << path
    end

    def filename
      path.split('/').last
    end

    def quiet
      '-q'
    end

    def png_optimizer_present?
      !png_optimizer_bin.nil? && !png_optimizer_bin.empty?
    end

    def png_optimizer_bin
      @png_optimzer_bin ||= binary_path
    end

  end
end
