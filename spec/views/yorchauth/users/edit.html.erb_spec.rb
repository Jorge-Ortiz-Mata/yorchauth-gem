require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      email: "MyString",
      token_id: "MyString",
      password_digest: "MyString",
      active: false
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[token_id]"

      assert_select "input[name=?]", "user[password_digest]"

      assert_select "input[name=?]", "user[active]"
    end
  end
end
