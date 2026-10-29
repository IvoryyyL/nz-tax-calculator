class Calculator
  BRACKETS = {
    1..15_600       => BigDecimal("0.105"),
    15_601..53_500  => BigDecimal("0.175"),
    53_501..78_100  => BigDecimal("0.30"),
    78_101..180_000 => BigDecimal("0.33"),
    180_001..       => BigDecimal("0.39")
  }.freeze

  def self.call(income)
    income = income.to_i

    lines = BRACKETS.map do |bracket, rate|
      taxable = income >= bracket.begin ? income.clamp(bracket) - bracket.begin + 1 : 0
      { bracket:, rate:, taxable:, tax: (taxable * rate).round(2) }
    end

    { income:, lines:, total: lines.sum(BigDecimal("0")) { _1[:tax] } }
  end
end
