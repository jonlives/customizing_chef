class Chef
  class Provider
    class Package
      class Awesomeator < Chef::Provider::Package

        def load_current_resource
          @current_resource = Chef::Resource::Package.new(@new_resource.name)
          current_resource.package_name(@new_resource.package_name)
          installed_version = get_installed_version
          if installed_version
            current_resource.version(installed_version.last.chomp)
          else
            current_resource.version(nil)
          end
        end

        def install_package(name, version)
          if ::File.exists?("/tmp/awesome_repo")
            packages = ::File.readlines("/tmp/awesome_repo")
          else
            packages = []
          end
          exists = !packages.select{|s|s.include?(name)}.empty?
          if exists
            packages = packages.map do |p|
              p.include?(name) ? "#{name}-#{version}\n" : p
            end
          else
            packages << "#{name}-#{version}\n"
          end
          write_to_package_db(packages)
        end

        def remove_package(name, version)
          packages = ::File.readlines("/tmp/awesome_repo")
          packages = packages.map{|p|p.include?(name) ? nil : p}
          write_to_package_db(packages)
        end

        private

        def get_installed_version
          repo_file = "/tmp/awesome_repo"
          if ::File.exists? repo_file
            packages = ::File.readlines(repo_file)
            results = packages.select do |p|
              p.include?(new_resource.package_name) ? p : nil
            end
            results.empty? ? nil : results.first.split("-")
          else
            return nil
          end
        end

        def write_to_package_db(package_data)
          ::File.open("/tmp/awesome_repo", 'w') do |file|
            file.write(package_data.join("\n"))
          end
        end
      end
    end
  end
end

Chef::Platform.set :platform => :centos, :resource => :package,
                   :provider => Chef::Provider::Package::Awesomeator