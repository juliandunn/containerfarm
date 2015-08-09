#
# Cookbook Name:: containerfarm
# Recipe:: default
#
# Copyright 2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package 'docker'

docker_service 'default' do
  action [:create, :start]
end

docker_image 'jdunn/sshd' do
  tag '1.0'
  action :pull
end

(node['containerfarm']['baseport']..node['containerfarm']['baseport']+node['containerfarm']['instances']).each do |p|
  docker_container "container on port #{p}" do
    image 'jdunn/sshd'
    container_name "sshd_#{p}"
    port "#{p}:22"
    detach true
    tag '1.0'
    action :run
  end
end

iptables_rule 'port_containerfarm' do
  variables(
    :startport => node['containerfarm']['baseport'],
    :endport   => node['containerfarm']['baseport'] + node['containerfarm']['instances']
  )
end
