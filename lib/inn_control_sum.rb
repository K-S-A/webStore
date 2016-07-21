module InnControlSum
  private
  #############################################################################
  # Returns true if INN is valid and false if not.
  #
  # number - Fixnum or String.
  # => Boolean
  #############################################################################
  def valid_inn?(number)
    number = number.to_s
    valid_format?(number) && valid_control_sum?(number)
  end

  #############################################################################
  # Check INN number length to be in [10, 12].
  #
  # number - String.
  # If length of inn is 10 or 12 return true, else false.
  # => Boolean
  #############################################################################
  def valid_format?(number)
    !!(number =~ /^(\d{10}|\d{12})$/)
  end

  #############################################################################
  # Matches calculated control sum to numbers last digit(s).
  #
  # number - String
  # => Boolean
  #############################################################################
  def valid_control_sum?(number)
    !!(number =~ /#{control_sum(number)}$/)
  end

  #############################################################################
  # Return control sum for INN
  #
  # number - String.
  # => String; '0' <= result <= '99'
  #############################################################################
  def control_sum(number)
    weights = [3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8, 0]
    
    if number.length == 10
      control_num(number, weights[2..-1])
    else
      control_num(number[0..-2], weights[1..-1]) + control_num(number, weights)
    end
  end

  #############################################################################
  # Return control number for INN and weights
  #
  # number - String. Length: 10-12.
  # weights - Array of Fixnum. Length: 10-12 numbers.
  # => String; '0' <= result <= '9'
  #############################################################################
  def control_num(number, weights)
    sum = number.each_char.with_index.inject(0) do |sum, (chr, i)|
      chr.to_i * weights[i] + sum
    end

    (sum % 11 % 10).to_s
  end
end
