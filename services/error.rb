class Error
  def self.add_error(error)
    if $errors.key?(error.class)
      $errors[error.class] += 1
    else
      $errors[error.class] = 1
    end
  end
end