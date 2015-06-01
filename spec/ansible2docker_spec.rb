require_relative '../lib/ansible2docker.rb'

RSpec.describe Ansible2Docker, '#parse_ansible' do
  context 'given this test.yml' do
    it 'outputs the correct command' do
      expect(Ansible2Docker.parse_ansible 'spec/test.yml').to eql 'docker run -p 9042:9042 -p 9160:9160 --link database:database --link app:app -v /opt:/root -v /usr/bin:/usr/local/bin --name web -e SOMEVAR:value -e SHH_SECRET:{{ from_the_vault }} quay.io/smashwilson/minimal-sinatra:latest'
    end
  end
end
