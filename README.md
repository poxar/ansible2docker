# Ansible2Docker

## Introduction

This is a simple ruby script that takes an ansible playbook or role yaml file as an input, looks for the first task with the docker module in it, then outputs a docker run command.

If you spend a lot of time wondering why your docker actions in ansible don't do what you want this could help you with your debugging. 

## Requirements

Requires ruby. Tested with `ruby 2.1.4p265` but the script is pretty simple so should work with most versions.

## To Run

```ruby
  ruby ansible2docker.rb path/to/playbook.yml
```

## example

Given somefile.yml, eg this one I found on some blog post:

```yml
- name: Some task
  raw: ls

- name: My application
  docker:
    name: web
    image: quay.io/smashwilson/minimal-sinatra:latest
    pull: always
    state: reloaded
    env:
      SOMEVAR: value
      SHH_SECRET: "{{ from_the_vault }}"
    link:
      - "database:database"
      - "app:app"
    volumes:
      - "/opt:/root"
      - "/usr/bin:/usr/local/bin"
    ports:
      - "9042:9042"
      - "9160:9160"
```

Run:

```ruby
  ruby ansible2docker.rb somefile.yml
```

Output:

```sh
  docker run -p 9042:9042 -p 9160:9160 --link database:database --link app:app -v /opt:/root -v /usr/bin:/usr/local/bin --name web -e SOMEVAR:value -e SHH_SECRET:{{ from_the_vault }} quay.io/smashwilson/minimal-sinatra:latest
```

## Test

To run the rspec tests run:

```sh
  bundle install
  rspec
```

## Future work

* Take docker command as input and output ansible yml. Docker2Ansible if you will.
* Be able to deal with more than one docker task.
* Write more than one test.
