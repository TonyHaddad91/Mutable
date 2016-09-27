require 'fileutils'
require 'json'

FileUtils.remove_dir('Output',force=true)
FileUtils.mkdir 'Output'
FileUtils.copy_entry('Android', 'Output', preserve = false, dereference_root = false, remove_destination = false)
FileUtils.copy_entry('iOS', 'Output', preserve = false, dereference_root = false, remove_destination = false)
json = JSON.parse(File.read('Data/Assets/config.json'))
appId=json['appId']
appName=json['appName']
versionCode=json['versionCode']
versionName=json['versionName']
#Building Android Project
FileUtils.copy_entry('Data/Assets', 'Output/Test/app/src/main/Assets', preserve = false, dereference_root = false, remove_destination = true)
FileUtils.copy_entry('Data/android_icon', 'Output/Test/app/src/main/res', preserve = false, dereference_root = false, remove_destination = true)
FileUtils.copy_entry('Data/android_splash', 'Output/Test/app/src/main/res/', preserve = false, dereference_root = false, remove_destination =false)

path = 'Output/Test/app/build.gradle'
lines = IO.readlines(path).map do |line|
  if line.include? "applicationId"
	"applicationId \"#{appId}\""
 elsif line.include? "versionCode"
    "versionCode #{versionCode}"
 elsif line.include? "versionName"
    "versionName \"#{versionName}\""	   
  else
  	line
  end

end
File.open(path, 'w') do |file|
  file.puts lines
end

path = 'Output/Test/app/src/main/AndroidManifest.xml'
lines = IO.readlines(path).map do |line|
  if line.include? "package="
	"package= \"#{appId}\""	 
	elsif line.include? "android:label="
	  "android:label=\"#{appName}\""	  
  else
  	line
  end

end
File.open(path, 'w') do |file|
  file.puts lines
end

#Building iOS Project

FileUtils.copy_entry('Data/Assets', 'Output/SmartWebView/SmartWebView/Assets', preserve = false, dereference_root = false, remove_destination = true)
FileUtils.copy_entry('Data/ios_icon', 'Output/SmartWebView/SmartWebView/Assets.xcassets/AppIcon.appiconset', preserve = false, dereference_root = false, remove_destination = true)
FileUtils.copy_entry('Data/ios_splash', 'Output/SmartWebView/SmartWebView/Assets.xcassets/launch-icon.imageset', preserve = false, dereference_root = false, remove_destination = true)

lines = IO.readlines("Output/SmartWebView/SmartWebView.xcodeproj/project.pbxproj").map do |line|
  if line.include? "PRODUCT_BUNDLE_IDENTIFIER"
  "PRODUCT_BUNDLE_IDENTIFIER =#{appId};"
elsif line.include?"PRODUCT_NAME"
    "PRODUCT_NAME=#{appName};"
  else
    line
  end
end
File.open("Output/SmartWebView/SmartWebView.xcodeproj/project.pbxproj", 'w') do |file|
  file.puts lines
end

lines = IO.readlines("Output/SmartWebView/SmartWebView/Base.lproj/LaunchScreen.storyboard").map do |line|
  line.gsub("red='0.11'", " red=0.12").gsub("green='0.22'"," green=0.33").gsub("blue='0.33'"," blue=0.44")
end
File.open("Output/SmartWebView/SmartWebView/Base.lproj/LaunchScreen.storyboard", 'w') do |file|
  file.puts lines
end






