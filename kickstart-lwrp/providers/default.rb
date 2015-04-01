#Base Provider
use_inline_resources #Notifications are impacted here.  if you do delayed notifications, they will be performed at the end of the resource run
                     #and not at the end of the chef run.  You do want to use this as it also affects internal resource notifications.

#Create Action
action :create do

  if !@current_resource.exists #Only create if it does not exist.

    #Converge our node
    converge_by("Creating.") do

      resp = create

      @new_resource.updated_by_last_action(resp)  #We set our updated flag based on the resource we utilized.

    end

  else

    Chef::Log.error "Our file already exists. Not Creating."
    #raise "Our file already exists."  #Use this to raise exceptions that stop a chef run.

  end

end

#Delete Action
action :delete do

  if @current_resource.exists #Only delete if it exists.

    #Converge our node
    converge_by("Deleting.") do

      resp = delete

      @new_resource.updated_by_last_action(resp)

    end

  else

    Chef::Log.error "Our file does not exist. Not deleting."

  end

end

#Override Load Current Resource
def load_current_resource

  @current_resource = Chef::Resource::KickstartLwrp.new(@new_resource.name)
  #kickstart-lwrp is the name of my cookbook.  chef will convert the name to a class so it becomes KickstartLwrp.  This is because there is a '-'
  #If I were to create something other than default, say service.rb in my provider/resource.  This would then be KickstartLwrpService.new and you
  #would access it in your recipes with kickstart_lwrp_service.

  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  @current_resource.string_param(@new_resource.string_param)  #DSL converts our parameters/attrbutes to methods to get and set the instance variable inside the Provider and Resource.
  @current_resource.boolean_param(@new_resource.boolean_param)
  @current_resource.array_param(@new_resource.array_param)
  @current_resource.hash_param(@new_resource.hash_param)

  #Get current state
  @current_resource.exists = ::File.file?("/var/#{ @new_resource.name }")

end

#Our Methods
def create

  t = template "/var/#{ new_resource.name }" do  #This is an instance of another resource, template.  You have access to methods, instance variables, etc., in another resource.
    variables ({
      :string_param => new_resource.string_param,  #normally you reference @new_resource.<variable>, but since you are in the instance of another resource, it's new_resource.<variable>
      :boolean_param => new_resource.boolean_param,
      :array_param => new_resource.array_param,
      :hash_param => new_resource.hash_param,
    })
    source 'tmpfile.erb'
    cookbook 'kickstart-lwrp'   #if you are providing the template file, you must state that it is coming from your cookbook.  If another cookbook calls this resource
    action :create              #and you do not state the cookbook, it will come from the calling cookbook's template dir.
  end
  Chef::Log.info "We created something here!" if t.updated_by_last_action?

  t.updated_by_last_action?  #We can access the method in the template resource to return the instance variable updated_by_last_action as true or false
                             #We in turn can use this to set our own updated_by_last_action instance variable.

end

def delete

  t = template "/var/#{ new_resource.name }" do
    source 'tmpfile.erb'
    cookbook 'kickstart-lwrp'   #If you are providing the template file, you must state that it is coming from your cookbook.
    action :delete
  end
  Chef::Log.info "We deleted something here!" if t.updated_by_last_action?

  t.updated_by_last_action?

end