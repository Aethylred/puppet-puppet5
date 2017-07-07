# puppet-puppet5

[![Build Status](https://travis-ci.org/Aethylred/puppet-puppet5.svg?branch=master)](https://travis-ci.org/Aethylred/puppet-puppet5)
[![Coverage Status](https://coveralls.io/repos/github/Aethylred/puppet-puppet5/badge.svg?branch=master)](https://coveralls.io/github/Aethylred/puppet-puppet5?branch=master)
![License](https://img.shields.io/badge/license-Apache%202-blue.svg)
[![experimental](http://badges.github.io/stability-badges/dist/experimental.svg)](http://github.com/badges/stability-badges)

# Introduction
A Puppet module to install and manage Puppet v5.x

This module currently installs and configures the following Puppet software and services:
- `puppet-agent`

# Prerequsites

This module requires a package repository to provide the Puppet v5.x packages. It includes the `puppet5::repos` class to configure the Puppetlabs repositories, however this class is not explicitly required to use this module. It is recommended that the class is installed using the following pattern:

## Using the Puppetlabs repositories

```puppet
class{'puppet5::repos':
  before => Class['puppet5']
}

include puppet5
```

## Using a local repository

```puppet
yumrepo{'local_mirror':
  enabled  => true,
  descr    => "A local mirror of the Puppetlabs Puppet5 Package el ${::operatingsystemmajrelease} repository",
  ...
  before  => Class['puppet5'],
}

include puppet5
```

# Classes

## `puppet5`

This wrapper class can be used to install, configure and manage the `puppet-agent` service using a single class declaration. It wrapps the `puppet5::agent::install`, `puppet5::agent::config` and `puppet5::agent::service` classes. All paramters are passed through to the other classes with minimal changes.

### Parameters

#### [String] package

The name of package to be installed. The default is `puppet-agent`

#### [String] version

The version of the package to be installed. The default is provided by Hiera.

#### [String] ensure

Ensure if the package is `installed` or `absent`, the default is `installed`

## `puppet5::agent::install`

This class installs the `puppet-agent` package and ensures that all the directories created by the package exist and have the correct ownership and permissions.

### Parameters

#### [String] package

The name of the package to be installed. The default is `puppet-agent`

#### [String] version

The version of the package to be installed. The default is provided by Hiera.

#### [String] ensure

Ensure if the package is `installed` or `absent`, the default is `installed`

## `puppet5::agent::config`

This class manages the `puppet.conf` configuration file. This module _only_ uses `puppet.conf` to manage the `[main]` and `[agent]` sections, configuration of other Puppet services will be in their own independent configuration files.

### Parameters

#### [Array[String]] basemodulepaths

An array of paths used to set the basemoduelpath setting that lists the directories where puppet checks for modules. Due to an [issue with how Puppet 5.0.0](https://tickets.puppetlabs.com/browse/PUP-7760) converts an `Array` to a `String`, spaces are stripped from paths when they substituted into `puppet.conf`

#### [String] ensure

If set to 'present' `puppet.conf` is deployed, if 'absent' it is removed. Default 'installed'

#### [String] server

Sets the FQDN of a puppet server or puppet master. Default leaves this unset.

#### [String] environment

Sets the puppet environment. Default leaves this unset.

#### [String] runinterval

Sets how often the puppet agent runs. Default leaves this unset. the `puppet-agent` will run every 30m by default.

## `puppet5::agent::service`

This class manages the state of the `puppet-agent` service.

### Parameters

## `puppet5::oscheck`

This internal class has no paramters. Used by other classes to check if the `puppet5` module is being used on a supported operating system.

## `puppet5::repos`

This class installes the Puppetlabs repositories for installing Puppet5. While this module requires a package repostory to provide the Puppet v5.x packages for installation, it should not depend on the Puppetlabs repository. This should allow configuration of local mirrors or other alternative repositories for installing Puppet v5.x

### Parameters

# Hiera
Many things are defined in Hiera that are not controlled by parameters. These can be over-ridden in a Hiera datastore on the local machine or Puppet server. Check the `data` directory for defaults.

# To Do

The following software and services are still to be done:

## Missing resources

- `puppet5::agent::service`: Not done yet, so we get this module on the forge sooner rather than later. For the badges you see...

## Puppet software

- `puppetdb`: it should configure; puppet-agent, puppetserver and the puppetb. It may be possible to set up `puppet-agent` to use a `puppetdb` service directly in deployments without a `puppetserver`
- `puppetserver`: it should set up a `puppetserver` that's integrated with a `puppetdb` that can be local or remote, and some kind of dashboard.
- `hiera`: it should only set up the configuration and the data store directory structure, but not the content of the data store.
