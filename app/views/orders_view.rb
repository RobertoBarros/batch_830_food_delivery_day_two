class OrdersView

  def ask_index
    puts "Enter index:"
    gets.chomp.to_i - 1
  end

  def list_riders(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username}"
    end
  end

  def list(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} | Customer: #{order.customer.name} | Delivered by #{order.employee.username}"
    end
  end
end
