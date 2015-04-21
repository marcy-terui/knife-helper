require 'spec_helper'
require 'knife/helper/config'

describe Knife::Helper::Config do

  describe 'normal' do
    conf = Knife::Helper::Config.new(test_file_path('normal.yml'))
    example { expect(conf.settings).to include('command_base' => 'bundle exec knife') }
    example { expect(conf.commands.first).to include('name' => 'test') }
    example { expect(conf.commands.first).to include('condition' => 'chef_environment:test') }
    example { expect(conf.commands.first['options']).to include('ssh-user' => 'ec2-user') }
    example { expect(conf.commands.first['options']).to include('sudo' => nil) }
  end

  describe 'merge' do
    conf = Knife::Helper::Config.new(test_file_path('merge.yml'))
    example { expect(conf.settings).to include('command_base' => 'bundle exec knife') }
    example { expect(conf.option_sets.first).to include('name' => 'test_set') }
    example { expect(conf.settings).to include('test01' => 'value01') }
    example { expect(conf.settings).to include('test02' => 'overwrited') }
    example { expect(conf.settings).to include('test03' => 'value03') }
    example { expect(conf.commands.first).to include('name' => 'test') }
    example { expect(conf.commands.first).to include('condition' => 'chef_environment:test') }
    example { expect(conf.commands.first['options']).to include('ssh-user' => 'ec2-user') }
    example { expect(conf.commands.first['options']).to include('sudo' => nil) }
  end
end
