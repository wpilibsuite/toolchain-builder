#!/usr/bin/env ruby
# usage: no args: list all packags
# one arg: download package

$repos = 'http://download.ni.com/ni-linux-rt/feeds/2015/arm/ipk/cortexa9-vfpv3/'
$base_img = %w{libc6 libgcc1 libstdc++6}

class Pkg
	attr_reader :name, :depends, :recs, :file
	def initialize(name)
		@name = name
		@rawinfo = `grep 'Package: #{name}$' Packages -A 30`.split("\n\n")[0]
		@file = @rawinfo.match(/^Filename: (.*)$/)[1]
		deps = (@rawinfo.match(/^Depends: (.*)$/)||[nil,""])[1]
		recs = (@rawinfo.match(/^Recommends: (.*)$/)||[nil,""])[1]
		@depends = deps.split(",").map{|x| Pkg.new(x.strip.split(/[ \(]/)[0])}
		@recs = deps.split(",").map{|x| Pkg.new(x.strip.split(/[ \(]/)[0])}
	end
	def download_name(base=[])
		return base if base.include? [@name, @file]
		base << [@name, @file]
		@depends.map{|x|x.download_name(base)}
		@recs.map{|x|x.download_name(base)}
		base
	end
	def download
		list = download_name
		p list
		list.delete_if{|x|$base_img.include? x[0]}
		list.each do |x|
			## popen would be nice....
			pid = fork do
				puts "Downloading #{x[0]}..."
				`wget -nc #{$repos}#{x[1]}`
			end

			Process.wait pid
		end
	end
end



`wget -nc #{$repos}Packages.gz`
`zcat Packages.gz > Packages`
if ARGV.length != 1
	puts `cat Packages| sed -n 's/Package: //p'`
	exit 0
else
	pkg = Pkg.new(ARGV[0])
	puts "getting dependencies..."
	rr = pkg.download
end

