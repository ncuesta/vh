#!/usr/bin/env ruby

##
# vh.rb
# Add virtual hosts to the apache configuration and the hosts file.
#
# Copyright (c) 2012 José Nahuel Cuesta Luengo
##

require 'pathname'

# Validate required arguments
if ARGV.length < 2
  puts 'Missing arguments.'
  puts 'Usage:'
  puts '  vh.rb path hostname'
  exit 1
end

path = Pathname.new(ARGV[0]).realpath
server_name = ARGV[1]

# Check the validity of path
if not File.directory? path
  puts "'#{path}' is not a valid path. Please correct that and try again."
  exit 2
end

# Check if the server is not already defined
vhosts_path = '/etc/apache2/extra/httpd-vhosts.conf'
add = true
open vhosts_path do | f |
  if f.grep(/ServerName\s+"#{server_name}"/i).length > 0
    puts "There already exists a server named '#{server_name}' in the virtual hosts file. Skipping..."
    add = false
  end  
end

# Append the vhost to the vhosts file
if add
  puts 'Adding virtual host to the virtual hosts file...'
  open vhosts_path, 'a+' do | f |
    f.puts <<-VHOST

# vh - #{server_name}
<Directory "#{path}">
  Allow From All
  AllowOverride All
</Directory>
<VirtualHost *:80>
	ServerName "#{server_name}"
	DocumentRoot "#{path}"
</VirtualHost>
# /vh - #{server_name}
VHOST
  end
  puts 'Done'
end

# Append the new host to the hosts file
hosts_path = '/etc/hosts'
add = true
open hosts_path do | f |
  if f.grep(/\W#{server_name}\W/i).length > 0
    puts "There is already a host named '#{server_name}'. Skipping..."
    add = false
  end
end

if add
  puts 'Adding host alias to hosts file...'
  open hosts_path, 'a+' do | f |
    f.puts <<-HOST
127.0.0.1 #{server_name} # vh
HOST
  end
  puts 'Done'
end

# Restart apache
puts 'Restarting apache...'
system 'apachectl restart'
puts 'Done'