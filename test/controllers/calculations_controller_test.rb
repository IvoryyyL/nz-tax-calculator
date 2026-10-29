require "test_helper"

class CalculationsControllerTest < ActionDispatch::IntegrationTest
  test "shows the form" do
    get root_path

    assert_response :success
    assert_select "input[name='calculation[income]']"
  end

  test "shows only the brackets the income reaches" do
    post calculations_path, params: { calculation: { income: "60000" } }

    assert_response :success
    assert_select ".tax-table tbody tr", 3
    assert_select "td", text: "Income over $53,500 and up to $78,100"
    assert_select "td", text: /Remaining income/, count: 0
    assert_select "tfoot", text: /\$10,220.50/
  end

  test "shows errors for a missing income" do
    post calculations_path, params: { calculation: { income: "" } }

    assert_response :unprocessable_entity
    assert_select ".errors li", text: "Income can't be blank"
  end
end
