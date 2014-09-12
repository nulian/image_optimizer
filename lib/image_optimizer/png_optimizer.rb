require "image_optimizer/base"

class ImageOptimizer
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
        warn 'Attempting to optimize a png without optipng installed. Skipping...'
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
      system(png_optimizer_bin, *command_options)
    end

    def command_options
      flags = ['-rem alla', '-rem text', '-nofilecheck']
      flags << quiet if options[:quiet]
      flags << path
      flags << path
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
