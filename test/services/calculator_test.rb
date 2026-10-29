require "test_helper"

class CalculatorTest < ActiveSupport::TestCase
  test "no tax on zero income" do
    result = Calculator.call(0)

    assert_equal 0, result[:total]
  end

  test "taxes the first bracket only" do
    # 15,600 * 10.5%
    assert_equal BigDecimal("1638"), Calculator.call(15_600)[:total]
  end

  test "spreads income across brackets" do
    result = Calculator.call(60_000)

    assert_equal [ 15_600, 37_900, 6_500, 0, 0 ], result[:lines].map { _1[:taxable] }
    assert_equal BigDecimal("10220.5"), result[:total]
  end

  test "taxes income above the top bracket at 39%" do
    assert_equal BigDecimal("57077.5"), Calculator.call(200_000)[:total]
  end

  test "works with the decimal income the form gives it" do
    income = Calculation.new(income: "60000").income

    assert_kind_of BigDecimal, income
    assert_equal BigDecimal("10220.5"), Calculator.call(income)[:total]
  end
end
