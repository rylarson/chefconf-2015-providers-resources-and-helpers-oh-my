#
# Cookbook Name:: kickstart-hwrp
# Recipe:: default
#
# Copyright 2014, Brian Stajkowski
#
# All rights reserved - Do Not Redistribute
#

my_kickstart 'exampleconfig' do  #We created a custom name for our provider my_kickstart
  string_param 'this is a string'
  boolean_param true
  array_param ['a', 'b', 'c']
  hash_param ({
    'a' => '2',
    'b' => '3'
  })
  action :create
end

my_kickstart 'exampleconfig' do
  action :delete
end