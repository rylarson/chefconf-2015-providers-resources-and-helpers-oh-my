
#Base Ubuntu Resource
class Chef::Resource::MyKickstartUbuntu < Chef::Resource::MyKickstart

  #This is the same but slightly different.  We state that it provides  our resource name
  #but in addition, we are stating that this will provide for my_kickstart on ubuntu. Or, you can state
  #that we can use it for all debian systems per the commented out block platform_family
  provides :my_kickstart_ubuntu
  provides :my_kickstart, os: "linux", platform: [ "ubuntu" ]#,platform_family: [ "debian" ]

  #Here we override our initialize block but state to bring in from our super class MyKickstart
  def initialize(name, run_context=nil)
    super
    @resource_name = :my_kickstart

  end

end