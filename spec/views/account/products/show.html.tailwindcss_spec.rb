require 'rails_helper'

RSpec.describe "account/products/show", type: :view do
  before(:each) do
    assign(:account_product, Account::Product.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Images/)
    expect(rendered).to match(/Additional Details/)
    expect(rendered).to match(/Is Active/)
    expect(rendered).to match(/Cost/)
    expect(rendered).to match(/Price/)
    expect(rendered).to match(/Created By/)
  end
end
