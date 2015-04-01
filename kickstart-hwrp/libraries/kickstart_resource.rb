
#Base Resource
class Chef::Resource::MyKickstart < Chef::Resource

  #This is for multiprovider, which is also in this cookbook.
  #We don't need the entire thing, ommited the rest as I'll write a quick provider for multiprovider as
  #an example, check multiprovider_resource and multiprovider_provider under libraries folder
  provides :my_kickstart #, :on_platforms => :all

  identity_attr :base_name #This is our name parameter, equal to LWRP: :name_attribute => true

  state_attrs :exists #Our state attributes where in LWRP we set: attr_accessor :exists

  #We need to override this from Chef::Resource as it does not contain anything
  def initialize(name, run_context=nil)
    super
    #Required values
    @resource_name = :my_kickstart  #This is our custom name.  We can name this anything we want really.
    #We don't need to state the provider, BUT if the provider was under a different name, maybe under a LWP,
    #we could explicitly set the provider name
    #@provider = Chef::Provider::MyKickstart
    @action = :create #This is the default action, equal to LWRP: default_action :create if defined?(default_action)
    @allowed_actions = [ :create, :delete ] #Equal to LWRP: actions :create, :delete

    @base_name = name #This is our name parameter, equal to LWRP: :name_attribute => true

    #These are our attributes defined with defaults
    #For LWRP(DSL) it basically creates these instance variables for us and sets the defaults
    @string_param = nil #These are our defaults, equal to LWRP: :default => nil
    @boolean_param = false
    @array_param = []
    @hash_param = {}

    #These are our state attributes where in LWRP we set: attr_accessor :exists
    @exists = nil
  end


  #LWRP DSL creates the methods for setting or returning the value of our attributes
  #Not too much to these.
  def string_param(arg=nil)
    set_or_return(
      :string_param,
      arg,
      :kind_of => [ String ]
    )
  end

  def boolean_param(arg=nil)
    set_or_return(
      :boolean_param,
      arg,
      :kind_of => [TrueClass, FalseClass]
    )
  end

  def array_param(arg=nil)
    set_or_return(
      :array_param,
      arg,
      :kind_of => [ Array ]
    )
  end

  def hash_param(arg=nil)
    set_or_return(
      :hash_param,
      arg,
      :kind_of => [ Hash ]
    )
  end


  #Then we define our set or return for our state attributes
  def exists(arg=nil)
    set_or_return(
      :exists,
      arg,
      :kind_of => [TrueClass, FalseClass]
    )
  end
end