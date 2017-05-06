
Pod::Spec.new do |s|

  s.name         = "WrapExisted"
  s.version      = "0.0.1"
  s.summary      = "A short description of WrapExsitance."

  s.description  = <<-DESC
  a demo for wrap existed component.
                   DESC

  s.homepage     = "http://xxxx/WrapExsitance"
  s.license      = "MIT"
  s.author       = { "leavez" => "gaojiji@gmail.com" }
  s.source       = { :git => "http://xxxx/WrapExsitance.git", :tag => "#{s.version}" }
  s.source_files  = "**/*.{h,mm,m}"
  s.private_header_files = 'private/**/*'
  s.dependency "CKWrapper"

end
