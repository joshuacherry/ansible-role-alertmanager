# encoding: utf-8

control '01' do
  impact 1.0
  title 'Verify alertmanager '
  desc 'Ensures alertmanager service and web is up and running'

  describe service('alertmanager') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
  describe user("prometheus") do
    it { should exist }
  end
  describe group("prometheus") do
    it { should exist }
  end

  describe port(9093) do
    it { should be_listening }
    its('processes') {should include 'alertmanager'}
  end
  describe http('http://127.0.0.1:9093') do
    its('status') { should cmp 200 }
  end

end