package "sriracha" do
  version "1.2.3"
  provider Chef::Provider::Package::Awesomeator
  action :remove
end

package "cholula" do
  version "1.2.4"
  provider Chef::Provider::Package::Awesomeator
end