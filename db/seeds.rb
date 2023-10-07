# frozen_string_literal: true

puts 'Start Seeding'

def load_relative(path)
  load(::File.join(::File.dirname(::File.absolute_path(__FILE__)), path))
end

load_relative('seeds/accounts.rb')
load_relative('seeds/users.rb')
