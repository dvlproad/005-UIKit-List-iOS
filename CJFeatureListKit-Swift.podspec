  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json

  # 上传到github公有库:
  #验证方法1：pod lib lint CJFeatureListKit-Swift.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJFeatureListKit-Swift.podspec --sources=cocoapods --allow-warnings --use-libraries --verbose
  #提交方法(github公有库)： pod trunk push CJFeatureListKit-Swift.podspec --allow-warnings
  
Pod::Spec.new do |s|  
  s.name         = "CJFeatureListKit-Swift"
  s.version      = "0.0.1"
  s.summary      = "各种列表"
  s.homepage     = "https://github.com/dvlproad/005-UIKit-List-iOS"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                 各种列表，可按需独立引入：
                 • CJFeatureListKit-Swift/LinkedMenu - 可联动的菜单
                 • CJFeatureListKit-Swift/CollectionView_SwiftUI - CollectionView_SwiftUI
                 • CJFeatureListKit-Swift/ScrollView_SwiftUI - ScrollView_SwiftUI
                 • CJFeatureListKit-Swift/Extension - Extension

                 每个子库可独立引入，详见各子库描述。
                 DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "9.0"
  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/dvlproad/005-UIKit-List-iOS", :tag => "CJFeatureListKit-Swift_0.0.1" }
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
    ss.source_files = "CJFeatureListKit-Swift/LinkedMenu/**/*.{swift}"
  end

  # CollectionView_SwiftUI
  s.subspec 'CollectionView_SwiftUI' do |ss|
    ss.source_files = "CJFeatureListKit-Swift/CollectionView_SwiftUI/**/*.{swift}"
  end

  # ScrollView_SwiftUI
  s.subspec 'ScrollView_SwiftUI' do |ss|
    ss.source_files = "CJFeatureListKit-Swift/ScrollView_SwiftUI/**/*.{swift}"
  end
  
  # Extension
  s.subspec 'Extension' do |ss|
    ss.source_files = "CJFeatureListKit-Swift/Extension/**/*.{swift}"
  end
  

end
