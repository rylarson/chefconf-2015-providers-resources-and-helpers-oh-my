#
# Cookbook Name:: kickstart-lwrp
# Recipe:: default
#
# Copyright 2014, Brian Stajkowski
#
# All rights reserved - Do Not Redistribute
#

kickstart_lwrp 'exampleconfig' do   #This is how we utilize the default.rb LWRP files we created.  It's simply the cookbook name: '-' converts to '_'.
  string_param 'this is a string'
  boolean_param true
  array_param ['a', 'b', 'c']
  hash_param ({
    'a' => '2',
    'b' => '3'
  })
  action :create
end

kickstart_lwrp 'exampleconfig' do
  action :delete
end