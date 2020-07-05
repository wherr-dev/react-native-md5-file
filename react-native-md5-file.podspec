require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-md5-file"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-md5-file
                   DESC
  s.homepage     = "https://github.com/wherr-dev/react-native-md5-file"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "lucatk" => "mail@lucakillmaier.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/wherr-dev/react-native-md5-file.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency "AWFileHash"
  # ...
  # s.dependency "..."
end

