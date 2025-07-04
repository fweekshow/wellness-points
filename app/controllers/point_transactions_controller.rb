class PointTransactionsController < ApplicationController
  before_action :set_point_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @sent_transactions = current_user.sent_transactions
    @received_transactions = current_user.received_transactions
  end

  def show
  end

  def new
    @point_transaction = current_user.sent_transactions.build
  end

  def create
    @point_transaction = current_user.sent_transactions.build(point_transaction_params)
    
    if @point_transaction.save
      redirect_to point_transactions_path, notice: 'Points were successfully sent.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @point_transaction.update(point_transaction_params)
      redirect_to point_transactions_path, notice: 'Transaction was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @point_transaction.destroy
    redirect_to point_transactions_path, notice: 'Transaction was successfully deleted.'
  end

  def claim
    @point_transaction = current_user.received_transactions.find(params[:id])
    @point_transaction.claim!
    redirect_to point_transactions_path, notice: 'Points were successfully claimed!'
  end

  private

  def set_point_transaction
    @point_transaction = current_user.sent_transactions.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @point_transaction = current_user.received_transactions.find(params[:id])
  end

  def point_transaction_params
    params.require(:point_transaction).permit(:receiver_id, :task, :points)
  end
end
