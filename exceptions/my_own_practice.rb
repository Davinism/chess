def sqrt(num)
  unless num >= 0
    raise ArgumentError.new "Cannot take sqrt of negative number"
  end

  (1..num).each do |value|
    return value if value ** 2 == num
  end
  nil
end

def main
    # begin
      puts "Please input a number"
      num = gets.to_i
      sqrt(num)
    rescue ArgumentError => e
      puts "Couldn't take the square root of #{num}"
      puts "Error was: #{e.message}"
      retry
    ensure
      puts "Remember, you can't take the square root of a negative number"
    # end
end
