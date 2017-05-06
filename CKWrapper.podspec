#
# Be sure to run `pod lib lint CKWrapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CKWrapper'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CKWrapper.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gaojiji@gmail.com/CKWrapper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT' }
  s.author           = { 'gaojiji@gmail.com' => 'gaoji@zhihu.com' }
  s.source           = { :git => 'https://github.com/gaojiji@gmail.com/CKWrapper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*'
  s.private_header_files = 'Sources/private/**/*'
  s.module_map = 'Sources/SupportFiles/CKWrapper.modulemap'

  s.dependency "ComponentKit"
  s.dependency "CKToolbox"

end
