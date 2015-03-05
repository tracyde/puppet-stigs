require 'spec_helper'
describe 'stigs' do

  context 'with defaults for all parameters' do
    let(:facts) {{ :kernel => 'Linux', 
	    :concat_basedir => '/tmp/concat',
	    :operatingsystem => 'RedHat',
	    :osfamily => 'RedHat',
	    :operatingsystemrelease => 6.6,
            :operatingsystemmajrelease => 6 }}
    it { should contain_class('stigs') }
  end
end
