Pod::Spec.new do |spec|
  spec.name         = "MBMacKit"
  spec.version      = "0.0.5"
  spec.summary      = "A utility library for macOS applications."
  spec.description  = <<-DESC
                       MBMacKit is a comprehensive utility library designed for macOS applications. It provides a range of tools and functionalities to streamline development processes.
                       DESC
  spec.homepage     = "https://github.com/LXJcom/MBMacKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "lxjcold" => "lxjcold@163.com" }
  spec.source       = { :git => "https://github.com/LXJcom/MBMacKit.git", :tag => "#{spec.version}" }
  spec.platform     = :osx, "10.13"
  spec.source_files = "MBMacKit/MBMacKit/*.{h,m,swift}"
end
