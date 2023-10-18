require 'rails_helper'

RSpec.describe "account/products/index", type: :view do
  before(:each) do
    assign(:account_products, [
      Account::Product.create!(
        account: nil,
        name: "Name",
        description: "MyText",
        short_description: "MyText",
        images: "Images",
        additional_details: "Additional Details",
        is_active: "Is Active",
        cost: "Cost",
        price: "Price",
        created_by: "Created By"
      ),
      Account::Product.create!(
        account: nil,
        name: "Name",
        description: "MyText",
        short_description: "MyText",
        images: "Images",
        additional_details: "Additional Details",
        is_active: "Is Active",
        cost: "Cost",
        price: "Price",
        created_by: "Created By"
      )
    ])
  end

  it "renders a list of account/products" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Images".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Additional Details".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Is Active".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cost".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Price".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Created By".to_s), count: 2
  end
end
