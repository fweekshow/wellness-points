class DashboardController < ApplicationController
  def index
    @user = current_user
    @allies = @user.allies
    @sent_transactions = @user.sent_transactions.limit(5)
    @received_transactions = @user.received_transactions.limit(5)
    @assigned_tasks = @user.assigned_tasks.limit(5)
    @received_tasks = @user.received_tasks.limit(5)
  end
end
