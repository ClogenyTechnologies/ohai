#
# Author:: Bryan McLellan (btm@loftninjas.org)
# Copyright:: Copyright (c) 2009 Bryan McLellan
# License:: Apache License, Version 2.0
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

provides "uptime", "uptime_seconds"

# kern.boottime=Tue Nov  1 14:45:52 2011

popen4("/sbin/sysctl kern.boottime") do |pid, stdin, stdout, stderr|
  stdin.close
  stdout.each do |line|
    if line =~ /kern.boottime=(.+)/
      uptime_seconds Time.new.to_i - Time.parse($1).to_i
      uptime seconds_to_human(uptime_seconds)
    end
  end
end

