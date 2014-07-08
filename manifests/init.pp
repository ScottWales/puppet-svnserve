## \file    manifests/init.pp
#  \author  Scott Wales <scott.wales@unimelb.edu.au>
#  \brief
#
#  Copyright 2014 Scott Wales
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# Install & configure svnserve
# ============================
#
# To use the default 'svn' user and group:
#
#     include svnserve
#
# To configure the 'svn' user and package separately:
#
#     class {'svnserve':
#         setupuser    => false,
#         setuppackage => false,
#     }
#

class svnserve (
  # Details for the subversion repository owner
  $user        = 'svn',
  $group       = 'svn',

  # Use Puppet to create the user?
  $setupuser   = true,

  # Install Subversion?
  $setuppackage = true,
) {

  validate_bool($setupuser)

  if $setupuser {
    group {$group:
      ensure => present,
    }
    user {$user:
      ensure  => present,
      gid     => $group,
      system  => true,
      shell   => '/sbin/nologin',
      require => Group[$group],
    }
  }

  if $setuppackage {
    package{'subversion':}
  }
}
