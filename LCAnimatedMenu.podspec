Pod::Spec.new do |s|
  s.name             = "LCAnimatedMenu"
  s.version          = File.read('VERSION')
  s.summary          = "A simple and animated menu to include in your apps	"
  s.description      = <<-DESC
                       A couple of UIView subclasses that allows you to include an animated menu in your own iOS applications.
                       DESC
  s.homepage         = "https://github.com/ThXou/LCAnimatedMenu"
  s.screenshots      = "https://raw.githubusercontent.com/ThXou/LCAnimatedMenu/master/menu2.png", "https://raw.githubusercontent.com/ThXou/LCAnimatedMenu/master/menu3.png"
  s.license          = 'MIT'
  s.author           = { "ThXou" => "yo@thxou.com" }
  s.source           = { :git => "https://github.com/ThXou/LCAnimatedMenu.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/thxou'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Source'
end