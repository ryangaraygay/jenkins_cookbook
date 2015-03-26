
# Cookbook Name:: jenkins_cookbook 
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe 'apt'
include_recipe 'git'
include_recipe 'jenkins::java'
include_recipe 'jenkins::master'

package 'curl'
package 'tree'

service "jenkins" do
  supports [:stop, :start, :restart]
  action [:start, :enable]
end

jenkins_plugin 'git' do
  notifies :restart, 'service[jenkins]', :immediately
end

jenkins_password_credentials 'Github Credential' do
  id 'fb44341a-81ab-458a-a1cd-26fdcf095e4e'
  description 'Github Credential'
  username 'ryangaraygay'
  password 'xxx'
end

xml = "testjob1.config.xml"

template xml do
  source 'testjob1.config.xml.erb'
end

jenkins_job 'TestJob1' do
  config xml
end
