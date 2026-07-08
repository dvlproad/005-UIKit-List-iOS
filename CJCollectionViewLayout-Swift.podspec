  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json
  
  # 上传到github公有库:
  #验证方法1：pod lib lint CJCollectionViewLayout-Swift.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJCollectionViewLayout-Swift.podspec --sources=cocoapods --allow-warnings --use-libraries --verbose
  #提交方法(github公有库)： pod trunk push CJCollectionViewLayout-Swift.podspec --allow-warnings --verbose

Pod::Spec.new do |s|
  s.name         = "CJCollectionViewLayout-Swift"
  s.version      = "0.1.0"
  s.summary      = "列表的各种layout布局"
  s.homepage     = "https://github.com/dvlproad/005-UIKit-List-iOS"

  s.description  = <<-DESC
                 列表的各种layout布局，可按需独立引入：
                 • CJCollectionViewLayout-Swift/FlowLayout - 自定义的 FlowLayout (如不同cell宽度时候左对齐)

                 每个子库可独立引入，详见各子库描述。
                 DESC
  

  #s.license      = {
  #  :type => 'Copyright',
  #  :text => <<-LICENSE
  #            © 2008-2016 Dvlproad. All rights reserved.
  #  LICENSE
  #}
  s.license      = "MIT"

  s.author   = { "dvlproad" => "" }

  s.platform     = :ios, "12.0"
 
  s.source       = { :git => "https://github.com/dvlproad/005-UIKit-List-iOS.git", :tag => "CJCollectionViewLayout-Swift_0.1.0" }
  # s.source_files  = "CJCollectionViewLayout-Swift/*.{h}"

  s.frameworks = "UIKit"
  s.swift_version = '5.0'

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJCollectionViewLayout-Swift/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'

  # 自定义的 FlowLayout (如不同cell宽度时候左对齐)
  s.subspec 'FlowLayout' do |ss|
    ss.source_files = "CJCollectionViewLayout-Swift/FlowLayout/**/*.{swift}"
  end

  # # UIView
  # s.subspec 'UIView' do |ss|
  #   # ss.source_files = "CJCollectionViewLayout-Swift/UIView/*.{swift}"

  #   # 视图拖动
  #  #  ss.subspec 'CJDragAction' do |sss|
  #  #    sss.source_files = "CJCollectionViewLayout-Swift/UIView/CJDragAction/**/*.{h,m}"
  # 	# end

  #   # 视图抖动
  # 	# ss.subspec 'CJShakeAction' do |sss|
  #  #    sss.source_files = "CJCollectionViewLayout-Swift/UIView/CJShakeAction/**/*.{h,m}"
  # 	# end

  # 	# 视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
  # 	ss.subspec 'CJPopupAction' do |sss|
  #     sss.source_files = "CJCollectionViewLayout-Swift/UIView/CJPopupAction/**/*.{swift}"
  # 	end

  #   # 视图手势
  # 	# ss.subspec 'CJGestureRecognizer' do |sss|
  #  #    sss.source_files = "CJCollectionViewLayout-Swift/UIView/CJGestureRecognizer/**/*.{h,m}"
  # 	# end

  # end


end
