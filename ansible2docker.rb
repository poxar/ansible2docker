require_relative 'lib/ansible2docker'

print Ansible2Docker.parse_ansible(ARGV[0]) if ARGV[0]
print "\n"
