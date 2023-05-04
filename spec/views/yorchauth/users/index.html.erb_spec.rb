require 'rails_helper'

RSpec.describe "users/index", type: :view do
  # before(:each) do
  #   assign(:users, [
  #     User.create!(
  #       email: "Email",
  #       token_id: "Token",
  #       password_digest: "Password Digest",
  #       active: false
  #     ),
  #     User.create!(
  #       email: "Email",
  #       token_id: "Token",
  #       password_digest: "Password Digest",
  #       active: false
  #     )
  #   ])
  # end

  # it "renders a list of users" do
  #   render
  #   cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  #   assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
  #   assert_select cell_selector, text: Regexp.new("Token".to_s), count: 2
  #   assert_select cell_selector, text: Regexp.new("Password Digest".to_s), count: 2
  #   assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  # end
end
