
Pod::Spec.new do |s|
  s.name             = 'ComponentSwift'
  s.version          = '0.2'
  s.summary          = 'ComponentSwift brings ComponentKit to swift'

  s.description      = <<-DESC
ComponentSwift brings ComponentKit to swift.

ComponentKit is a react-inspired native view framework for iOS developed by Facebook. It intruduce a new abstract layer (component) to automatically handle view reuse, meanwhile provide the ability to build smooth list view easily.

ComponentSwift is an objc wrapper of ComponentKit and refined for swift. ComponentSwift is designed to be a subset of ComponentKit, implementing the most commonly used features.
                       DESC

  s.homepage         = 'https://github.com/leavez/ComponentSwift'
  s.license          = { :type => 'MIT' }
  s.author           = { 'leavez' => 'gaojiji@gmail.com' }
  s.source           = { :git => 'https://github.com/leavez/ComponentSwift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.1'

  s.source_files = 'Sources/**/*.{swift,h,m,mm}'
  s.private_header_files = 'Sources/private/**/*.{h}'
  s.module_map = 'Sources/SupportFiles/ComponentSwift.modulemap'

  s.dependency "ComponentKit", "0.15.1"
  s.dependency "CKTableViewTransactionalDataSource"

end
