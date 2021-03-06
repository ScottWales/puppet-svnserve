#!/bin/bash
## \file    tests/setup.sh
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
#  
rpm -i http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
yum install --assumeyes puppet

# yum install --assumeyes subversion autoconf automake libtool apr-devel
# puppet module install puppetlabs-vcsrepo
# puppet module install puppetlabs-concat

# Build the module
cd /vagrant
puppet module build

# Install the module
MODULE=$(ls -t /vagrant/pkg/*.tar.gz  | head -n 1)
puppet module install "$MODULE"

# Ignore puppet module failures
exit 0
