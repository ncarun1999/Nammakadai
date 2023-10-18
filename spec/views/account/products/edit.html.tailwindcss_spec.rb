require 'rails_helper'

RSpec.describe "account/products/edit", type: :view do
  let(:account_product) {
    Account::Product.create!(
      account: nil,
      name: "MyString",
      description: "MyText",
      short_description: "MyText",
      images: "MyString",
      additional_details: "MyString",
      is_active: "MyString",
      cost: "MyString",
      price: "MyString",
      created_by: "MyString"
    )
  }

  before(:each) do
    assign(:account_product, account_product)
  end

  it "renders the edit account_product form" do
    render

    assert_select "form[action=?][method=?]", account_product_path(account_product), "post" do

      assert_select "input[name=?]", "account_product[account_id]"

      assert_select "input[name=?]", "account_product[name]"

      assert_select "textarea[name=?]", "account_product[description]"

      assert_select "textarea[name=?]", "account_product[short_description]"

      assert_select "input[name=?]", "account_product[images]"

      assert_select "input[name=?]", "account_product[additional_details]"

      assert_select "input[name=?]", "account_product[is_active]"

      assert_select "input[name=?]", "account_product[cost]"

      assert_select "input[name=?]", "account_product[price]"

      assert_select "input[name=?]", "account_product[created_by]"
    end
  end
end
