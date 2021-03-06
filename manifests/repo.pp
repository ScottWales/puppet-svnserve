## \file    manifests/repo.pp
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

# Serve up a svn repo over svn+ssh
# ================================
#
# Create a repository accessible at svn+ssh://localhost:svn/puppet-svnserve:
#
#     svnserve::repo {'/svn/puppet-svnserve':
#     }

define svnserve::repo (
) {
  include svnserve

  $repo  = $title

  $user  = $svnserve::user
  $group = $svnserve::group

  vcsrepo {$repo:
    ensure   => present,
    provider => svn,
    user     => $user,
    group    => $group,
    require  => [User[$user],Group[$group]],
  }

  file {$repo:
    recurse => true,
    mode    => 'g+rw',
    require => Vcsrepo[$repo],
  }

  svnserve::repo::inithook {[
    'pre-commit',
    'post-commit',
    'pre-revprop-change',
    'post-revprop-change',
    'start-commit',
  ]:
    repo    => $repo,
    require => Vcsrepo[$repo],
  }

}
