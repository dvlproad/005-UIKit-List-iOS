Pod::Spec.new do |s|
  # 上传到github公有库:
  #验证方法1：pod lib lint CJListDemo-Swift.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJListDemo-Swift.podspec --sources=master --allow-warnings --use-libraries --verbose
  #提交方法(github公有库)： pod trunk push CJListDemo-Swift.podspec --allow-warnings
  
  s.name         = "CJListDemo-Swift"
  s.version      = "0.0.1"
  s.summary      = "列表相关的Demo"
  s.homepage     = "https://github.com/dvlproad/005-UIKit-List-iOS"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                   A longer description of CJListDemo-Swift in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "11.0"
  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/dvlproad/005-UIKit-List-iOS", :tag => "CJListDemo-Swift_0.0.1" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # 可联动的菜单
  s.subspec 'LinkedMenu' do |ss|
    ss.source_files = "CJListDemo-Swift/LinkedMenu/**/*.{swift}"
    ss.dependency "SnapKit"
    ss.dependency "CQDemoKit/Demo_DataSourceAndDelegate"
    ss.dependency "CJListKit-Swift/LinkedMenu"
  end
  

end
