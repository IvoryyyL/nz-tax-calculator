module CalculationsHelper
  # Worded like the IRD calculator:
  #   "Up to $15,600"
  #   "Income over $15,600 and up to $53,500"
  #   "Remaining income over $180,000"
  def bracket_label(bracket)
    over = number_to_currency(bracket.begin - 1, precision: 0)
    up_to = number_to_currency(bracket.end, precision: 0) if bracket.end

    if bracket.begin <= 1
      "Up to #{up_to}"
    elsif up_to
      "Income over #{over} and up to #{up_to}"
    else
      "Remaining income over #{over}"
    end
  end

  # 0.105 => "10.5%", 0.30 => "30%"
  def rate_percentage(rate)
    number_to_percentage(rate * 100, precision: 1, strip_insignificant_zeros: true)
  end

  # Share of the whole income paid in tax.
  def effective_rate(result)
    result[:income].zero? ? 0 : result[:total] / result[:income]
  end
end
