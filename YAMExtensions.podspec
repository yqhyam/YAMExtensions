
Pod::Spec.new do |s|


s.name         = "YAMExtensions"
s.version      = "0.0.1"
s.summary      = "SwiftExtensions"

s.description  = <<-DESC
you can select some category methods of foundation that you want,this methods can help own improve develop quickly
DESC

s.homepage     = "https://github.com/yqhyam/YAMExtensions"
s.license      = "MIT"

s.author             = { "yqhyam" => "yqhyam@gmail.com" }

s.platform     = :ios, "10.0"

s.source       = { :git => "https://github.com/yqhyam/YAMExtensions.git", :tag => "0.0.1" }

s.source_files  = "YAMExtensions/**/*.{swift}", "YAMExtensions/**/*.{swift}"

s.requires_arc = true

s.swift_version = '5.0'

end
