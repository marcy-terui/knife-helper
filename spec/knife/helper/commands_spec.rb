require 'spec_helper'
require 'knife/helper/commands'

describe Knife::Helper::Commands do
  before do
    @cmd = Knife::Helper::Commands.new(config)
  end

  let(:config) do
    {
      'settings' => {
        'command_base' => '/test/knife'
      },
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
  end

  describe '#complete_option' do
    example {expect(@cmd.complete_option('a')).to eq '-a'}
    example {expect(@cmd.complete_option('aa')).to eq '--aa'}
  end

end
