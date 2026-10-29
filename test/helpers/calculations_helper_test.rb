require "test_helper"

class CalculationsHelperTest < ActionView::TestCase
  test "labels brackets like the IRD calculator" do
    labels = Calculator.call(600_000)[:lines].map { bracket_label(_1[:bracket]) }

    assert_equal [
      "Up to $15,600",
      "Income over $15,600 and up to $53,500",
      "Income over $53,500 and up to $78,100",
      "Income over $78,100 and up to $180,000",
      "Remaining income over $180,000"
    ], labels
  end

  test "shows rates without trailing zeros" do
    assert_equal "10.5%", rate_percentage(BigDecimal("0.105"))
    assert_equal "30%", rate_percentage(BigDecimal("0.30"))
  end

  test "works out the effective rate" do
    assert_equal BigDecimal("0.285"), effective_rate(Calculator.call(200_000)).round(3)
    assert_equal 0, effective_rate(Calculator.call(0))
  end
end
