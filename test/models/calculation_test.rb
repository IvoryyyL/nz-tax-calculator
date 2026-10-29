require "test_helper"

class CalculationTest < ActiveSupport::TestCase
  test "is valid with an income" do
    assert Calculation.new(income: "60000").valid?
  end

  test "is valid with zero income" do
    assert Calculation.new(income: "0").valid?
  end

  test "turns the form's text into a decimal" do
    calculation = Calculation.new(income: "60000.50")

    assert_kind_of BigDecimal, calculation.income
    assert_equal BigDecimal("60000.50"), calculation.income
  end

  test "needs an income" do
    calculation = Calculation.new(income: "")

    assert_not calculation.valid?
    assert_includes calculation.errors[:income], "can't be blank"
  end

  test "rejects text that is not a number" do
    calculation = Calculation.new(income: "abc")

    assert_not calculation.valid?
    assert_includes calculation.errors[:income], "is not a number"
  end

  test "rejects a negative income" do
    calculation = Calculation.new(income: "-1")

    assert_not calculation.valid?
    assert_includes calculation.errors[:income], "must be greater than or equal to 0"
  end
end
