require 'fileutils'
require 'json'

# Clean up
FileUtils.remove_dir('Output', true)
FileUtils.mkdir('Output')
FileUtils.copy_entry('Android', 'Output/Android', false, false, false)
FileUtils.copy_entry('iOS', 'Output/iOS', false, false, false)

# Read config
json = JSON.parse(File.read('Input/Assets/config.json'))
app_id        = json['appId']
app_name      = json['appName']
version_code  = json['versionCode']
version_name  = json['versionName']
splash_color  = json['splashColor']

# Generate Android project
FileUtils.copy_entry('Input/Assets', 'Output/Android/app/src/main/Assets', false, false, true)
FileUtils.copy_entry('Input/android_icon', 'Output/Android/app/src/main/res', false, false, true)
FileUtils.copy_entry('Input/android_splash', 'Output/Android/app/src/main/res/', false, false, false)

path = 'Output/Android/app/build.gradle'
lines = IO.readlines(path).map do |line|
  if line.include? 'applicationId'
    "applicationId \"#{app_id}\""
  elsif line.include? 'versionCode'
    "versionCode #{version_code}"
  elsif line.include? 'versionName'
    "versionName \"#{version_name}\""
  else
  	line
  end
end
File.open(path, 'w') do |file|
  file.puts(lines)
end

path = 'Output/Android/app/src/main/AndroidManifest.xml'
lines = IO.readlines(path).map do |line|
  if line.include? 'android:label='
	  "android:label=\"#{app_name}\""
  else
  	line
  end
end
File.open(path, 'w') do |file|
  file.puts lines
end

path = 'Output/Android/app/src/main/res/values/colors.xml'
lines = IO.readlines(path).map do |line|
  if line.include? 'splash_color'
    "<color name=\"splash_color\">#{splash_color}</color>"
  else
    line
  end
end
File.open(path, 'w') do |file|
  file.puts lines
end

# Generate iOS project
FileUtils.copy_entry('Input/Assets', 'Output/iOS/SmartWebView/SmartWebView/Assets', false, false, true)
FileUtils.copy_entry('Input/ios_icon', 'Output/iOS/SmartWebView/SmartWebView/Assets.xcassets/AppIcon.appiconset', false, false, true)
FileUtils.copy_entry('Input/ios_splash', 'Output/iOS/SmartWebView/SmartWebView/Assets.xcassets/launch-icon.imageset', false, false, true)

lines = IO.readlines('Output/iOS/SmartWebView/SmartWebView.xcodeproj/project.pbxproj').map do |line|
  if line.include? 'PRODUCT_BUNDLE_IDENTIFIER'
    "PRODUCT_BUNDLE_IDENTIFIER =#{app_id};"
  elsif line.include? 'PRODUCT_NAME'
    "PRODUCT_NAME=#{app_name};"
  else
    line
  end
end
File.open('Output/iOS/SmartWebView/SmartWebView.xcodeproj/project.pbxproj', 'w') do |file|
  file.puts lines
end

rgb_splash_color = (splash_color.match(/#(..?)(..?)(..?)/))[1..3]
rgb_splash_color!.map { |x| x + x } if splash_color.size == 4
lines = IO.readlines('Output/iOS/SmartWebView/SmartWebView/Base.lproj/LaunchScreen.storyboard').map do |line|
  line.gsub!("red=\"0.11\"", "red=\"#{rgb_splash_color[0].hex / 255.0}\"")
  line.gsub!("green=\"0.22\"", "green=\"#{rgb_splash_color[1].hex / 255.0}\"")
  line.gsub!("blue=\"0.33\"", "blue=\"#{rgb_splash_color[2].hex / 255.0}\"")
  line
end
File.open('Output/iOS/SmartWebView/SmartWebView/Base.lproj/LaunchScreen.storyboard', 'w') do |file|
  file.puts lines
end
