require_relative '../views/employee_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = EmployeeView.new
  end

  # ACTION
  def login
    # 1. Ask for the username
    employee_username = @view.ask_for('username')
    # 3. Ask for the password
    employee_password = @view.ask_for('password')
    # 5. Check username and password
    # 5.1 retrieve the right employee instance
    employee = @employee_repository.find_by_username(employee_username)
    # 5.2 compare the username and the password
    # 6. IF it's right
    if employee && employee.password == employee_password
      # 6.1 Redirect to the right menu
      # router should display the right menu
      employee
    else
      # 6.2 Ask for eveything again
      @view.wrong_credentials
      login # recursive call to the method login
    end
  end
end
