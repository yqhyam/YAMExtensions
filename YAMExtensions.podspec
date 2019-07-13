
Pod::Spec.new do |s|


    s.name         = 'YAMExtensions'
    s.version      = '0.0.2'
    s.summary      = 'for swift extensions'


    s.homepage     = 'https://github.com/yqhyam/YAMExtensions'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }

    s.author             = { 'yqhyam' => 'yqhyam@gmail.com' }

    s.ios.deployment_target = '10.0'

    s.source       = { :git => 'https://github.com/yqhyam/YAMExtensions.git', :tag => s.version.to_s }

    s.source_files  = 'YAMExtensions/*.swift'

    s.requires_arc = true

    s.swift_version = '5.0'

end
