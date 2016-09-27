appId, appName, versionName, versionCode  = ARGV
require 'fileutils'
FileUtils.remove_dir('Output',force=true)
FileUtils.mkdir 'Output'
FileUtils.copy_entry('Android', 'Output', preserve = false, dereference_root = false, remove_destination = false)
FileUtils.copy_entry('iOS', 'Output', preserve = false, dereference_root = false, remove_destination = false)
#Building Android Project
FileUtils.copy_entry('Data/Assets', 'Output/Test/app/src/main/Assets', preserve = false, dereference_root = false, remove_destination = true)
FileUtils.copy_entry('Data/android_icon', 'Output/Test/app/src/main/res', preserve = false, dereference_root = false, remove_destination = true)
FileUtils.copy_entry('Data/android_splash', 'Output/Test/app/src/main/res/drawable', preserve = false, dereference_root = false, remove_destination = true)

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










