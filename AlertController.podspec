Pod::Spec.new do |s|
  s.name = "AlertController"
  s.version = "1.0"
  s.summary = "Alert Controller helper"
  s.homepage = "https://github.com/andrewclaus/AlertController"
  s.license = "MIT"
  s.author = { "Claus, Andrew" => "aclaus@umich.edu" }
  s.source = { :git => "https://github.com/andrewclaus/AlertController.git", :tag => s.version }
  
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  
  s.source_files = s.name + "/**/*.{h,m,swift}"
end
