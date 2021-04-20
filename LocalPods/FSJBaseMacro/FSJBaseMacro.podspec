

Pod::Spec.new do |spec|
  spec.name         = "FSJBaseMacro"
  spec.version      = "0.0.1"
  spec.summary      = "FSJBaseMacro"

  spec.description  = <<-DESC
    Base header
  DESC

  spec.homepage     = "https://github.com"
  spec.license      = "MIT"
  spec.author             = { "SmallMas" => "fanshij@163.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "8.0"
  spec.ios.deployment_target = "10.0"

  spec.source       = { :git => "", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "FSJBaseMacro/**/*.{h,m}"

  spec.public_header_files = "FSJBaseMacro/**/*.h"

  spec.requires_arc = true
  #spec.dependency "YYCategories"

end
