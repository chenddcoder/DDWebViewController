Pod::Spec.new do |s|
  s.name         = "DDWebViewController"
  s.version      = "1.0.1"
  s.summary      = "web load"
  s.homepage     = "https://github.com/chenddcoder/DDWebViewController"
  s.license      = "MIT"
  s.author             = { "chenddcoder" => "chenddcoder@foxmail.com" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/chenddcoder/DDWebViewController.git", :tag => "1.0.1" }
  s.source_files  = "DDWebViewController/DDWebViewController/Classes/*.{h,m}"
  s.requires_arc = true
end
