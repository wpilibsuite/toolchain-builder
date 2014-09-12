#!/usr/bin/env ruby
# This script debianizes all the argumnts ipk

require 'fileutils'

DEBEMAIL="root@localhost"
DEBFULLNAME="Automatic Packaging"

maintainer="#{DEBFULLNAME} <#{DEBEMAIL}>"
# note this requires better handling...
$base_img = %w{libc6 libgcc1 libstdc++6}

def field(ipk,bit)
	`dpkg-deb -f #{ipk} #{bit}`
end

ARGV.each do |ipk|
 	puts	"working on #{ipk}..."
	pkg = "frc-xipk-#{field(ipk,"Package").strip}"
	FileUtils.rm_rf "#{ipk}_deb" if File.exist? "#{ipk}_deb"
	FileUtils.mkdir_p "#{ipk}_deb/debian/#{pkg}/usr/arm-frc-linux-gnueabi/"
	FileUtils.mkdir_p "#{ipk}_deb/debian/#{pkg}/DEBIAN/"
	control = "Source: #{pkg}\n"
	control << "Section: #{field(ipk,"Section")}"
	control << "Maintainer: #{maintainer}\n"
	control << "Priority: optional\nStandards-Version: 3.9.4\n\n"
	control << "Package: #{pkg}\nArchitecture: all\n"
	control << "Description: #{field(ipk,"Description")} .\n This package was automatically generated from an ipkg for arm via\n frc-convert-deb.rb and any errors are your own fault. If you think\n that this package should be provided and supported, file a bug."
	control << "Depends: #{field(ipk,"Depends").split(",").delete_if{|x|$base_img.include? x.strip.split(" ")[0]}.map{|x|"frc-xipk-#{x.strip}"}.join(", ")}\n"
	control << "Recommends: #{field(ipk,"Recommends").split(",").delete_if{|x|$base_img.include? x.strip.split(" ")[0]}.map{|x|"frc-xipk-#{x.strip}"}.join(", ")}\n\n"

	File.write("#{ipk}_deb/debian/control", control)
	File.write("#{ipk}_deb/debian/#{pkg}/DEBIAN/control", control)
	File.write("#{ipk}_deb/debian/compat", "9")
	`cd #{ipk}_deb/debian/#{pkg}/usr/arm-frc-linux-gnueabi/ && ar x #{File.absolute_path(ipk)} && tar xf data.tar.gz`
	`cd #{ipk}_deb/debian/#{pkg}/usr/arm-frc-linux-gnueabi/ && rm control.tar.gz data.tar.gz debian-binary`
	`cd #{ipk}_deb/ && bash -c "DEBEMAIL='#{DEBEMAIL}' DEBFULLNAME='#{DEBFULLNAME}' dch -v '#{field(ipk, "Version").strip}' 'Creating Package via frc-convert-deb.rb. This is an automated import from NI ipkg files.' --create -D UNRELEASED --package '#{pkg}'"`
	`cd #{ipk}_deb/ && fakeroot -- bash -c 'dh_installchangelogs && dh_compress && dh_fixperms && dh_gencontrol && dh_md5sums && dh_builddeb'`

end
