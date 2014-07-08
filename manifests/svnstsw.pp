## \file    manifests/svnstsw.pp
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

# Install the svnstsw wrapper program
# ===================================
#
# Svnstsw wraps the svnserve command to allow users to work on the repository
# without being given filesytem access
#
#    include svnserve::svnstsw
#

class svnserve::svnstsw (

) {
  include svnserve

  file {'/usr/local/bin/svnserve.real':
    ensure => link,
    target => '/usr/bin/svnserve',
  }

  vcsrepo {'/tmp/svnstsw':
    ensure   => present,
    source   => 'http://svn.apache.org/repos/asf/subversion/trunk/contrib/server-side/svnstsw',
    provider => svn,
    notify   => Exec['autogen.sh svnstsw'],
  }

  exec {'autogen.sh svnstsw':
    command => '/tmp/svnstsw/autogen.sh',
    creates => '/tmp/svnstsw/configure',
    notify  => Exec['configure svnstsw'],
  }

  exec {'configure svnstsw':
    command => '/bin/bash configure',
    path    => ['/bin','/usr/bin'],
    cwd     => '/tmp/svnstsw',
    creates => '/tmp/svnstsw/Makefile',
    notify  => Exec['make svnstsw'],
  }

  exec {'make svnstsw':
    command => 'make install',
    path    => ['/bin','/usr/bin'],
    cwd     => '/tmp/svnstsw',
    creates => '/usr/local/bin/svnstsw',
  }

  file {'/usr/local/bin/svnstsw':
    owner  => $svnserve::user,
    group  => $svnserve::group,
    mode   => '2555',
  }

  file {'/usr/local/bin/svnserve':
    ensure => link,
    target => '/usr/local/bin/svnstsw',
  }

}
