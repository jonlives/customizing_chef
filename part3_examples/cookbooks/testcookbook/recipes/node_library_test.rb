node.interface_statuses do |if_name, status|
  Chef::Log.warn("The status of interface #{if_name} is #{status}")
end