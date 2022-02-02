require_relative '../views/orders_view'
require_relative '../views/meals_view'
require_relative '../views/customers_view'
class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new

  end

  def add
    # 1. Listar todos os meals e perguntar para o usuário qual ele quer
    meals = @meal_repository.all
    @meals_view.list(meals)
    index = @view.ask_index
    meal = meals[index]


    # 2. Listar todos os customers e perguntar para o usuário qual ele quer
    customers = @customer_repository.all
    @customers_view.list(customers)
    index = @view.ask_index
    customer = customers[index]


    # 3. Listar employees do tipo rider e perguntar para o usuário qual ele quer
    riders = @employee_repository.all_riders
    @view.list_riders(riders)
    index = @view.ask_index
    rider = riders[index]

    # 4. Instanciar uma order
    new_order = Order.new(meal: meal, customer: customer, employee: rider)

    # 5. Adicionar order no repositório
    @order_repository.create(new_order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.list(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }
    @view.list(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }
    @view.list(orders)
    index = @view.ask_index
    order = orders[index]

    order.deliver!

    @order_repository.save_csv

  end

end
