Pod::Spec.new do |s|
  s.name             = "MLBusinessComponents"
  s.version          = "1.59.0"
  s.summary          = "MLBusinessComponents for iOS"
  s.homepage         = "https://www.mercadolibre.com"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "PX Team - Juan Sanzone & Esteban Boffa"
  s.source           = { :git => "https://github.com/mercadolibre/mlbusiness-components-ios", :tag => s.version.to_s }
  s.swift_version    = '5.9'
  s.platform         = :ios, '15.0'
  s.requires_arc     = true
  s.default_subspec = 'Default'
  s.static_framework = true

  s.subspec 'Default' do |default|
    default.source_files = ['Source/**/**/**/*.{h,m,swift}']
    default.resource_bundles = { 'MLBusinessComponentsResources' => ['Source/Assets/*.xcassets'] }
    s.dependency 'MLUI', '~> 5.0'
    s.dependency 'AndesUI', '~> 3.147'
  end
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
end
