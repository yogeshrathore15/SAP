#
# Cookbook Name:: key_generation
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#Author :: Yogesh Rathore
# All rights reserved - Do Not Redistribute
#
line2 = ""

file "C:\\key_gen.txt" do
  action :create
end
remote_file "C:\\key_gen.txt" do
  source "https://www.famkruithof.net/uuid/uuidgen"
end

File.open('C:\\key.txt').each do |line|
    if line.match(/RFC/) 
    print "#{line}"
	line1=line.split("<h3>").last
	print "#{line1}"
	line2=line1.split("</h3>").first
	print "#{line2}"
  end
end

=begin
ruby_block "execute block" do
 block do
  File.open('key.txt').each do |line|
    if line.match(/RFC/) 
    print "#{line}"
	line1=line.split("<h3>").last
	print "#{line1}"
	line2=line1.split("</h3>").first
	print "#{line2}"
  end
 end
  action :run
end
end
=end

puts "#{line2}"