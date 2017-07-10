module Capistrano
  class FileNotFound < StandardError
  end
end

def absolute_writable_paths
  linked_dirs = fetch(:linked_dirs)
  fetch(:file_permissions_paths).map do |d|
    Array(linked_dirs).include?(d) ? shared_path.join(d) : release_path.join(d)
  end
end

namespace :permissions do
  desc "Set permissions"
  task :set do
    set :fixpermissions, ask('Do you want to fix folder permissions ? y|n', 'y')
    next unless fetch(:fixpermissions) == 'y'
    on roles(:web) do
      info "Fixing permissions ..."
      invoke 'deploy:set_permissions:acl'
    end
  end

  task :check do
    invoke 'deploy:set_permissions:check'
  end

  desc "Check folder ACL"
  task :checkAcl => :check do
    next unless any? :file_permissions_paths
    on roles fetch(:file_permissions_roles) do |host|
      users = fetch(:file_permissions_users).push(host.user)
      res = Array.new
      paths = absolute_writable_paths
      paths.each { |path|
        users.each { |user|
          test = capture("getfacl -p -d #{path}|grep -q user:#{user}:rwx && echo ok || echo nok")
          if test == 'ok'
            res.push(test)
          end
          ## getfacl -p -d #{path}|grep user:#{user}:rwx
        }
      }

      if users.length*paths.length != res.length
        info "You should set permissions on your files."
        invoke 'permissions:set'
      else
        info "Permissions are properly set."
      end
    end
  end
end
