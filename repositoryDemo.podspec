Pod::Spec.new do |s|
    s.name         = 'repositoryDemo'
    s.version      = '1.0.0'
    s.summary      = 'An easy way to use pull-to-refresh'
    s.homepage     = 'https://github.com/foolsong/drawDemo'
    s.license      = 'MIT'
    s.authors      = {'yjSong' => 'ldusyj@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/CoderMJLee/MJRefresh.git', :tag => s.version}
    s.source_files = 'DrawByCollectionView/EasyCharts/**/*.{h,m}'
    s.resource     = 'DrawByCollectionView/EasyCharts/Common/EasyChartsBundle.bundle'
    s.requires_arc = true
end
