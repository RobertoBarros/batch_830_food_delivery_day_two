require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def sign_in

    # 1. Perguntar o username
    username = @view.ask_username

    # 2. Perguntar o password
    password = @view.ask_password

    # 3. Encontrar um employee dado o username
    employee = @employee_repository.find_by_username(username)

    # 4. Se employee existe verificar se o password confere
    if employee && employee.password == password
      # Username e password correto => retornar o employee
      @view.welcome
      return employee
    else
      # Username inexistente ou password errado => chamar novamente o sign_in
      @view.wrong_credentials
      sign_in
    end

  end

end
