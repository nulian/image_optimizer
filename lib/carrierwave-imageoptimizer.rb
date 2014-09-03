require "image_optimizer"

module CarrierWave
  module ImageOptimizer
    def optimize(options = {})
      ::ImageOptimizer.new(current_path, options).optimize
    end
  end
end
