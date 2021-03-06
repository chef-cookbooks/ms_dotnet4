#
# Author:: Timothy Smith (<tsmith@chef.io>)
# Cookbook:: ms_dotnet4
# Recipe:: default
#
# Copyright:: 2012-2016, Webtrends, Inc.
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

if platform?('windows')
  if node['platform_version'].to_f >= 6.1
    windows_package 'Microsoft .NET Framework 4 Client Profile' do
      source node['ms_dotnet4']['http_url']
      installer_type :custom
      options '/quiet /norestart'
      success_codes [0, 3010]
      action :install
      not_if { File.exist?('C:/Windows/Microsoft.NET/Framework/v4.0.30319') }
    end
  else
    Chef::Log.warn('The Microsoft .NET Framework 3.5 Chef recipe currently only supports Windows 7 and 2008 R2 and later.')
  end
else
  Chef::Log.info('Microsoft .NET Framework 4.0 can only be installed on the Windows platform.')
end
