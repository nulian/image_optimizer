module CarrierWave
  module ImageOptimizerHolder
    def optimize(options = {})
      ::ImageOptimizerHolder.new(current_path, options).optimize
    end
  end
end
