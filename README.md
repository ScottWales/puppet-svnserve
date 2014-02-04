Puppet SVN+SSH server
=====================

Sets up an access-controlled SVN server using svnstsw. This means that users
that log on to the server with SSH don't need to have full write access to the
SVN repository, instead access is mediated through the svnstsw wrapper.

Testing
-------

A test script & vagrant file is provided that will check SVN access, to run:

    ./test.sh

The module has been tested using Centos 6.4

Prerequisites
-------------

Svnstsw is built from source, which requires the following packages:

 - subversion
 - gcc
 - autoconf
 - automake
 - libtool
 - apr-devel

Additionally the following Puppet modules are used:

 - puppetlabs-vcsrepo
 - puppetlabs-concat

Usage
-----

Install svnstsw:

    node default {

        include svnserve::svnstsw

        ...
    }

Add a subversion repository at '/svn/myrepo':

    svnserve::repo { '/svn/myrepo': }

Add a post-commit hook

    svnserve::repo::hook { 'myrepo post commit',
        repo    => '/svn/myrepo',
        hook    => 'post-commit',
        content => 'echo $0',
    }
