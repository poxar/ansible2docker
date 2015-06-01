require 'yaml'

module Ansible2Docker

  def self.parse_ansible(path)
    playbook = load_yaml(path)
    docker_command = find_docker_command(playbook)
    create_docker_command(docker_command)
  end

  def self.create_docker_command(command)
    output = "docker run"

    args = [['ports', '-p'], ['link', '--link'], ['volumes', '-v']]
    args.each do |a|
      output += args_from_array(command, *a)
    end

    output += " --name #{command['name']}" if command['name'] 
    if command['env']
      command['env'].each do |e|
        output += " -e #{e[0]}:#{e[1]}"
      end
    end
    output += " #{command['image']}" if command['image'] 

    output
  end

  def self.args_from_array(command, name, flag)
    output = ""
    if command[name]
      command[name].each do |i|
        output += " #{flag} #{i}"
      end
    end
    output
  end

  def self.load_yaml(path)
    YAML.load_file(path)
  end

  def self.find_docker_command(playbook)
    playbook.select { |p| p['docker'] }.first['docker']
  end
end
