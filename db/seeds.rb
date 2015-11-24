
puts 'ROLES'

YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ name: role }, without_protection: true)
  puts 'role: ' << role
end

puts 'DEFAULT USERS'
user = User.find_by_email(ENV['ADMIN_EMAIL'])
params = { name: ENV['ADMIN_NAME'], 
           email: ENV['ADMIN_EMAIL'],
           password: ENV['ADMIN_PASSWORD'],
           password_confirmation: ENV['ADMIN_PASSWORD']}

if user
  puts "Update user"
  user.update(params)
else
  puts "Create user"
  user = User.create(params)
end

user.label_name = 'Etc'
puts "user: #{user.name}"
user.add_role :admin
user.skip_confirmation!
user.save!
