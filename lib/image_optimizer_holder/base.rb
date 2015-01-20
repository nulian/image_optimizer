class ImageOptimizerHolder
  GEM_ROOT = File.expand_path File.join(File.dirname(__FILE__), "../../")

  class Base
    def binary_path
      @binary_path ||= begin
        try_system_binary or try_vendored_binaries or ""
      end
    end

    private

    def try_system_binary
      system_binary = `which #{@name}`.chomp
      system_binary if system_binary.length > 0
    end

    def try_vendored_binaries
      # use the first vendored binary that doesn't shit the bed when we ask for its version
      vendored_binaries = Dir["#{GEM_ROOT}/bin/#{@name}.*"].sort
      vendored_binaries.find do |path|
        system("#{path} -version 2> /dev/null > /dev/null")
      end
    end
  end
end
