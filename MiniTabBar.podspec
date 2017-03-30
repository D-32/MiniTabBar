Pod::Spec.new do |s|
  s.name             = 'MiniTabBar'
  s.version          = '1.0.2'
  s.summary          = 'Clean and simple UITabBar alternative'

  s.description      = <<-DESC
Written in Swift 3 this UITabBar alternative has a much cleaner look. Titles are only shown when tapped on.
                       DESC

  s.homepage         = 'https://github.com/d-32/MiniTabBar'
  s.screenshots     = 'https://raw.githubusercontent.com/D-32/MiniTabBar/master/screenshot.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dylan Marriott' => 'info@d-32.com' }
  s.source           = { :git => 'https://github.com/d-32/MiniTabBar.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dylan36032'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MiniTabBar/Classes/**/*'
end
