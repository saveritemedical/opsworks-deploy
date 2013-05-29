node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::interspire application #{application} as it is not an PHP app")
    next
  end

	execute "symlink to config" do
		command "ln -s /mnt/interspire/config #{deploy[:deploy_to]}/shared/conf"
		action :run
		not_if do
		 	::FileTest.directory?("#{deploy[:deploy_to]}/shared/conf")
		end
	end

	execute "symlink to cache" do
		command "ln -s /mnt/interspire/cache #{deploy[:deploy_to]}/shared/cache"
		action :run
		not_if do
		 	::FileTest.directory?("#{deploy[:deploy_to]}/shared/cache")
		end
	end

end
