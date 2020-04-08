Pod::Spec.new do |s|
  s.name         = "JMFileManager"
  s.version      = "0.0.1"
  s.summary      = "JMFileManager makes it easy to deal with sandbox data container in Swift"
  s.homepage     = "https://github.com/Juuman-Song/JMFileManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Juuman-Song" => "juumansong@163.com" }
  
  s.requires_arc = true
  s.swift_version = "5.0"
  s.platform = :ios, "9.0"
  s.source   = { :git => "https://github.com/Juuman-Song/JMFileManager.git", :tag => s.version }
  s.source_files = "JMFileManager/*.swift"
end
