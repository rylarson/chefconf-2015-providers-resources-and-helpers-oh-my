#
# Cookbook Name:: kickstart-hlwrp
# Recipe:: default
#
# Copyright 2014, Brian Stajkowski
#
# All rights reserved - Do Not Redistribute
#

example_hlwrp 'exampleconfig' do   #We created a custom name so it's simply the custom name.
  string_param 'this is a string'
  boolean_param true
  array_param ['a', 'b', 'c']
  hash_param ({
    'a' => '2',
    'b' => '3'
  })
  action :create
end

example_hlwrp 'exampleconfig' do
  action :delete
end