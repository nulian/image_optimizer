class ImageOptimizer
  class PNGOptimizer
    attr_reader :path

    def initialize(path)
      @path = path
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
      ['png', 'gif'].include? extension(path)
    end

    def extension(path)
      path.split(".").last.downcase
    end

    def optimize_png
      system "optipng -o7 #{path}"
    end

    def png_optimizer_present?
      `which optipng` && $?.success?
    end

  end
end