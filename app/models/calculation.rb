class Calculation
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :income, :decimal
  validates :income, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # What the user typed, before it became a decimal. `numericality` checks this
  # when it exists, so "abc" is rejected instead of being turned into 0.
  def income_before_type_cast
    @attributes["income"].value_before_type_cast
  end
end
