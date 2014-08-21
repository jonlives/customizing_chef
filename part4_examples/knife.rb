chef_server_url 'http://127.0.0.1:8889'
node_name 'cctest'
client_key '/tmp/part4_examples/customizing_chef.pem'
cache_options( :path => '/tmp/part4_examples/checksums' )
chef_repo_path '/tmp/part4_examples/chef-zero/playground'