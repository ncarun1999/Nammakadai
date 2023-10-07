puts 'Seeding Accounts'

@account = Account.new

@account.tap do |target|
  target.name = 'Arun'
  target.phone = '9080912902'
  target.subdomain = 'arun'
  target.shop_id = 'AK_01'
  target.order_prefix = 'AK'
  target.last_ordered_number = 1000
  target.description = 'Welcome to our shop Arun Kumar C!'
  target.account_type = 'fancy_store'
  target.additional_details = {
    'onboarded_on' => '2023-10-02T10:57:10.157+05:30',
    'current_onboard_step' => 3,
    'user_agreement_accepted_on' => '2023-10-02T10:42:42.612+05:30'
  }
end
