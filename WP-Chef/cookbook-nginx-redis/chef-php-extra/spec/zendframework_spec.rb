require 'chefspec'

describe 'chef-php-extra::zendframework' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-php-extra::zendframework' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
