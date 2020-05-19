Pod::Spec.new do |s|
  s.name = "##PackageName##"
  s.version = "##PackageTag##"
  s.summary = "A short description of FGExtensionSDK."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.author = { 'flamegrace' => 'flamegrace@hotmail.com' }
  s.homepage = 'https://github.com/flamegrace/FGExtensionSDK'
  s.description = "TODO: Add long description of the pod here."
  s.frameworks = "UIKit"
  s.libraries = ["c++"]
  s.source = { :path => '.' }

  s.subspec 'Libs' do |ss|
    ss.source_files = 'Libs/*.*{a}'
  end
  
  s.subspec 'Headers' do |ss|
    ss.public_header_files = 'Headers/**/*.h'
    ss.source_files = 'Headers/**/*.h'
  end

  s.platform     = :ios, "8.0"
  s.vendored_libraries = 'Libs/*.a'
  s.vendored_frameworks = 'Vendors/*.framework'
  s.resources = ['Resource/**/*.bundle']
  s.dependency "FGFoundation"
end
