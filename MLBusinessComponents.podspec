Pod::Spec.new do |s|
  s.name             = "MLBusinessComponents"
  s.version          = "1.8"
  s.summary          = "MLBusinessComponents for iOS"
  s.homepage         = "https://www.mercadolibre.com"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "PX Team - Juan Sanzone & Esteban Boffa"
  s.source           = { :git => "https://github.com/mercadolibre/mlbusiness-components-ios", :tag => s.version.to_s }
  s.swift_version    = '4.2'
  s.platform         = :ios, '10.0'
  s.requires_arc     = true
  s.default_subspec = 'Default'

  s.subspec 'Default' do |default|
    default.resources = ['Source/Assets/*.xcassets']
    default.source_files = ['Source/**/**/**/*.{h,m,swift}']
    s.dependency 'MLUI', '~> 5.0'
  end
end
