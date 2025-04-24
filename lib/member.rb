class Member
  REQUIRED_FIELDS = %i[name role skills bio].freeze

  def initialize(attributes = {})
    @attributes = attributes.transform_keys(&:to_sym)
    validate!
  end

  def to_h
    @attributes
  end

  private

  def validate!
    missing_fields = REQUIRED_FIELDS - @attributes.keys
    raise "Missing required fields: #{missing_fields.join(', ')}" unless missing_fields.empty?
  end
end
