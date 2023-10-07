puts 'Seeding Users'

@user = @account.users.new
@user.tap do |target|
  target.first_name = 'Arun'
  target.last_name = 'Kumar'
  target.email = 'ncarun1999@gmail.com'
  target.password = '123qwe123'
  target.phone = '9080912902'
  target.confirmed_at = '2023-10-07T11:42:05+05:30'
end
@user.save!
@user.add_role :admin
@user.add_role :super_admin
