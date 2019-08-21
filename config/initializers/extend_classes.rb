class Array
  def average
    inject(&:+) / size.to_f
  end
end
