# Knife::Helper

[![Gem Version](https://badge.fury.io/rb/knife-helper.svg)](http://badge.fury.io/rb/knife-helper) [![Build Status](https://travis-ci.org/marcy-terui/knife-helper.svg?branch=master)](https://travis-ci.org/marcy-terui/knife-helper)

Helper and Command builder for knife (chef-server, knife-zero, etc)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'knife-helper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install knife-helper

## Usage

### knife helper init
Generate `.knife.helper.yml`,`.chef/knife.rb` and `Berksfile`,`Cheffile`(by option)

```
$ knife helper init (options)
-c [PATH1,PATH2...],             Path to Cookbooks
    --cookbook-path
-l, --local                      local mode (for zero)
-r, --repo-path PATH             Path to Chef Repogitory
-B, --berks                      Generate Berksfile
-L, --librarian                  Generate Cheffile
```

### knife helper list
List all command names (and options)

```
$ knife helper init (options)
-a, --all                        Print all commands and options
-f, --file FILE                  Path to config file(yaml)
-F, --format FORMAT              Which format to use for output
```

### knife helper build
Build and output some command that built from the configuration file.

```
$ knife helper build REGEX (option)
-f, --file FILE                  Path to config file(yaml)
-F, --format FORMAT              Which format to use for output
```

### knife helper exec
Execute some command that built from the configuration file.

```
$ knife helper exec NAME (option)
-f, --file FILE                  Path to config file(yaml)
-p, --print-only                 Only print the command that built by helper
```

## Configuration

```yaml
---
includes:
  - example.yml

settings:
  command_base: bundle exec knife

option_sets:
  - name: default
    options:
      ssh-user: ec2-user
      identity-file: ~/.ssh/example.pem
      hint: ec2

commands:
  - name: default
    command: zero chef_client
    condition: chef_environment:production
    option_sets: default
    options:
      attribute: ec2.public_ipv4
```

### includes
Include some external configuration files.  
Type: `Array`

### option_sets:name
Name of options for use commands.  
Type: `String`

### commands:options
Set od options.  
Type: `Hash`

### settings:command_base
Path to `knife` execution script.
Type: `String`

### commands:name
Name of command for execution.  
Type: `String`

### commands:condition
Condition for search and execute command.  
Type: `String`

### commands:option_sets
Option set to be used in the command.  
Type: `String` or `Array`

### commands:options
Command options.  
Type: `Hash`

## ChangeLog
see [CHANGELOG][changelog]

## Contributing

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make. For
example:

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

Created and maintained by [Masashi Terui][author] (<marcy9114@gmail.com>)

## License

Apache 2.0 (see [LICENSE][license])

[author]:           https://github.com/marcy-terui
[issues]:           https://github.com/marcy-terui/knife-helper/issues
[license]:          https://github.com/marcy-terui/knife-helper/blob/master/LICENSE.txt
[changelog]:        https://github.com/marcy-terui/knife-helper/blob/master/CHANGELOG.md
[repo]:             https://github.com/marcy-terui/knife-helper
