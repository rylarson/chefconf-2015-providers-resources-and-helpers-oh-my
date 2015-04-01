#Base Resource
actions :create, :delete  #Actions that we support.  Must be stated in our provider action :create do.

default_action :create if defined?(default_action)  #Our default action, can be anything.

#Name Space
attribute :base_name, :name_attribute => true, :kind_of => String, :required => false, :default => 'default'  #This is what is passed in kickstart_lwrp "<name>" do.

#Example Parameters
attribute :string_param, :kind_of => String, :required => false, :default => nil  #Here are four commonly used attribute types.
attribute :boolean_param, :kind_of => [ TrueClass, FalseClass ], :required => false, :default => false
attribute :array_param, :kind_of => Array, :required => false, :default => []
attribute :hash_param, :kind_of => Hash, :required => false, :default => {}

attr_accessor :exists  #This is a standard ruby accessor, use this to set flags for current state.