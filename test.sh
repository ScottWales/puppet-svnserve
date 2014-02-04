#!/bin/bash
## \file    test.sh
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

vagrant up

mkdir .test
vagrant ssh-config > .test/ssh-config
export SVN_SSH="ssh -F .test/ssh-config"

svn info svn+ssh://default/var/svn/test

RC=$?

rm -r .test

exit $RC

