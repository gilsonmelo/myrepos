#
# Cookbook Name:: file
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
cookbook_file "/etc/myserver.conf" do
      source "sample.txt"
      owner "root"
      group "root"
      mode "644"
    end#
