Pod::Spec.new do |s|
  s.name         = "miniKit"
  s.version      = "1.0.3"
  s.summary      = "ios开发常用工具或分类"
  s.description  = <<-DESC

                     Testing Private Podspec.
                     * Markdown format.
                     * Don't worry about the indent, we strip it!
                     * 填写描述，一定要写一点，不然报错
                   DESC

  s.homepage     = "https://github.com/dongshangtong/minikit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "dongshangtong" => "dongshangtong@gmail.com" }
  s.platform     = :ios
  s.platform     = :ios, "10.0"
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/dongshangtong/minikit.git", :tag => "#{s.version}" }
 # s.source_files  = "Classes", "Classes/**/*.{h,m}"
 # s.public_header_files = "Classes/**/*.h"

  s.source_files  = "Classes", "Classes/minikit.h"
  s.public_header_files = "Classes/minikit.h" 


 s.subspec 'MNShineButton' do |sh|
 sh.source_files = "Classes/MNShineButton/*.{h,m}"

end

 s.subspec 'MNValidationView' do |va|
 va.source_files = "Classes/MNValidationView/*.{h,m}"

end

  s.resources = "Resources/*.png"
  s.requires_arc = true
 # s.dependency "JSONKit", "~> 1.4"
end
