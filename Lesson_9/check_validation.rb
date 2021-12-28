module CheckValidation
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end
end
