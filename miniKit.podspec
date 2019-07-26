Pod::Spec.new do |s|
  s.name         = "miniKit"
  s.version      = "1.0.7"
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
  s.platform     = :ios, "11.0"
  s.ios.deployment_target = "11.0"
  s.source       = { :git => "https://github.com/dongshangtong/minikit.git", :tag => "#{s.version}" }
 # s.source_files  = "Classes", "Classes/**/*.{h,m}"
 # s.public_header_files = "Classes/**/*.h"

  s.source_files  = "Classes", "Classes/minikit.h"
  s.public_header_files = "Classes/minikit.h" 


 s.subspec 'MNShineButton' do |sh|
 sh.source_files = "Classes/MNShineButton/*.{h,m,xib}"

end

 s.subspec 'MNValidationView' do |va|
 va.source_files = "Classes/MNValidationView/*.{h,m,xib}"

end

 s.subspec 'MNKeyboard' do |va|
 va.source_files = "Classes/MNKeyboard/*.{h,m,xib}"

end

 s.subspec 'MNMovableButton' do |va|
 va.source_files = "Classes/MNMovableButton/*.{h,m,xib}"

end

 s.subspec 'MNCycleImageView' do |va|
 va.source_files = "Classes/MNCycleImageView/*.{h,m,xib}"

end

  s.resources = "Resources/*.png"
  s.requires_arc = true
  s.dependency "Masonry"
  s.dependency "SDWebImage"
end
