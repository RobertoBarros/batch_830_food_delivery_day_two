class MealsView
  def ask_name
    puts "Enter meal name:"
    gets.chomp
  end

  def ask_price
    puts "Enter meal price:"
    gets.chomp.to_i
  end

  def list(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} | Name: #{meal.name} | Price $ #{meal.price}"
    end
  end
end
