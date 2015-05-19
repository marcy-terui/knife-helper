require 'spec_helper'
require 'knife/helper/commands'

describe Knife::Helper::Commands do
  before do
    @cmd = Knife::Helper::Commands.new(
      config['settings']['command_base'],
      config['commands'],
      config['option_sets']
    )
  end

  let(:config) do
    {
      'settings' => {
        'command_base' => '/test/knife'
      },
      'option_sets' => [
        {
          'name' => 'test_set01',
          'options' => {
            'i' => "~/.ssh/knife-helper-example.pem"
          }
        },
        {
          'name' => 'test_set02',
          'options' => {
            'x' => "ec2-user"
          }
        }
      ],
      'commands' => [
        {
          'name' => 'knife-zero',
          'command' => 'zero chef_client',
          'condition' => 'name:*',
          'options' => {
            'sudo' => nil,
            'x' => 'ubuntu',
            'attribute' => 'ipaddress'
          }
        },
        {
          'name' => 'knife-zero-opts-1',
          'command' => 'zero chef_client',
          'condition' => 'name:*',
          'option_sets' => ['test_set01'],
          'options' => {}
        },
        {
          'name' => 'knife-zero-opts-2',
          'command' => 'zero chef_client',
          'condition' => 'name:*',
          'option_sets' => ['test_set01', 'test_set02'],
          'options' => {
            'sudo' => nil,
            'x' => 'ubuntu',
            'attribute' => 'ipaddress'
          }
        },
        {
          'name' => 'knife-zero-opts-3',
          'command' => 'zero chef_client',
          'condition' => 'name:*',
          'option_sets' => 'test_set02',
          'options' => nil
        },
        {
          'name' => 'help',
          'command' => 'help',
          'condition' => nil,
          'options' => nil
        }
      ]
    }
  end

  describe '#build' do
    example do
      expect(@cmd.build('knife-zero')).to eq(
        '/test/knife zero chef_client \'name:*\' --sudo -x ubuntu --attribute ipaddress')
    end
    example do
      expect(@cmd.build('help')).to eq(
        '/test/knife help')
    end
    example do
      expect(@cmd.build('knife-zero-opts-1')).to eq(
        '/test/knife zero chef_client \'name:*\' -i ~/.ssh/knife-helper-example.pem')
    end
    example do
      expect(@cmd.build('knife-zero-opts-2')).to eq(
        '/test/knife zero chef_client \'name:*\' -i ~/.ssh/knife-helper-example.pem -x ubuntu --sudo --attribute ipaddress')
    end
    example do
      expect(@cmd.build('knife-zero-opts-3')).to eq(
        '/test/knife zero chef_client \'name:*\' -x ec2-user')
    end
  end

  describe '#complete_option' do
    example {expect(@cmd.complete_option('a')).to eq '-a'}
    example {expect(@cmd.complete_option('aa')).to eq '--aa'}
  end

end
