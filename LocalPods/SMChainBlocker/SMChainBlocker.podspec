

Pod::Spec.new do |spec|
  spec.name         = "SMChainBlocker"
  spec.version      = "0.0.1"
  spec.summary      = "链式编程，运用在TableView上"

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

  spec.source_files  = "Classes", "SMChainBlocker/**/*.{h,m}"

  spec.public_header_files = "SMChainBlocker/**/*.h"

  spec.requires_arc = true
  spec.dependency "CHGAdapter"

end
