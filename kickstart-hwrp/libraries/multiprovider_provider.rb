
#Base Ubuntu Provider
class Chef::Provider::MyKickstartUbuntu < Chef::Provider::MyKickstart

  #This is the same but slightly different.  We state that it provides  our resource name
  #but in addition, we are stating that this will provide for my_kickstart on ubuntu. Or, you can state
  #that we can use it for all debian systems per the commented out block platform_family
  provides :my_kickstart, os: "linux", platform: [ "ubuntu" ]#,platform_family: [ "debian" ]

  def load_current_resource

    extend Chef::DSL::IncludeAttribute #Extend the includeattribute module as before

    #Even though our class is called MyKickStartUbuntu, we need to create an instance of the
    #MyKickstart, which will then detect what resource will be used for the specific platform.
    @current_resource = Chef::Resource::MyKickstart.new(@new_resource.name)

    include_attribute "kickstart-hwrp::default" #Include our attributes file as before

    #We will need to restate the import of the @new_resource to @current_resource as we are overriding load_current_resource
    @current_resource.string_param(@new_resource.string_param)
    @current_resource.boolean_param(@new_resource.boolean_param)
    @current_resource.array_param(@new_resource.array_param)
    @current_resource.hash_param(@new_resource.hash_param)

    #Get current state
    #We again need to ensure the state is handled correctly for ubuntu, as it has a different file name
    @current_resource.exists(::File.file?("/var/helloubuntu_#{ @new_resource.name }"))

  end


  #***We do not need to override or recreate our action_create and action_delete methods as we can reuse them.  It is possible
  #to completely override all methods if the ubuntu resource/provider was drastically different.


  #Override the create method for ubuntu
  def create
    #This is the same as the HWRP but instead we are putting in something speicific for ubuntu.
    t = template "#{ node[:kickstart_hwrp][:test_path] }/helloubuntu_#{ new_resource.name }" do
      variables ({
        :string_param => new_resource.string_param,
        :boolean_param => new_resource.boolean_param,
        :array_param => new_resource.array_param,
        :hash_param => new_resource.hash_param,
      })
      source 'tmpfile.erb'
      cookbook 'kickstart-hwrp'
      action :create
    end
    Chef::Log.info "We created something here!" if t.updated_by_last_action?

    t.updated_by_last_action?

  end

  #Override the delete method for ubuntu
  def delete

    t = template "#{ node[:kickstart_hwrp][:test_path] }/helloubuntu_#{ new_resource.name }" do
      source 'tmpfile.erb'
      cookbook 'kickstart-hwrp'
      action :delete
    end
    Chef::Log.info "We deleted something here!" if t.updated_by_last_action?

    t.updated_by_last_action?

  end

end