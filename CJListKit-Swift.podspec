Pod::Spec.new do |s|
  # 上传到github公有库:
  #验证方法1：pod lib lint CJListKit-Swift.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJListKit-Swift.podspec --sources=master --allow-warnings --use-libraries --verbose
  #提交方法(github公有库)： pod trunk push CJListKit-Swift.podspec --allow-warnings
  
  s.name         = "CJListKit-Swift"
  s.version      = "0.0.1"
  s.summary      = "数据万象SDK"
  s.homepage     = "https://github.com/dvlproad/005-UIKit-List-iOS"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                   A longer description of CJListKit-Swift in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "9.0"
  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/dvlproad/005-UIKit-List-iOS", :tag => "CJListKit-Swift_0.0.1" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # 自定义的 FlowLayout (如不同cell宽度时候左对齐)
  s.subspec 'FlowLayout' do |ss|
    ss.source_files = "CJListKit-Swift/FlowLayout/**/*.{swift}"
  end

  # 可联动的菜单
  s.subspec 'LinkedMenu' do |ss|
    ss.source_files = "CJListKit-Swift/LinkedMenu/**/*.{swift}"
  end

  s.subspec 'CollectionView_SwiftUI' do |ss|
    ss.source_files = "CJListKit-Swift/CollectionView_SwiftUI/**/*.{swift}"
  end
  
  s.subspec 'Extension' do |ss|
    ss.source_files = "CJListKit-Swift/Extension/**/*.{swift}"
  end
  

end
