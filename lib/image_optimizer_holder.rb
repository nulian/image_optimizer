require 'image_optimizer_holder/version'
require 'image_optimizer_holder/jpeg_optimizer'
require 'image_optimizer_holder/png_optimizer'
require 'image_optimizer_holder'

class ImageOptimizerHolder
  attr_reader :path, :options

  def initialize(path, options = {})
    @path    = path
    @options = options
  end

  def optimize
    JPEGOptimizer.new(path, options).optimize
    PNGOptimizer.new(path, options).optimize
  end
end


