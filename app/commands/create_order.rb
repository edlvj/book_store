class CreateCart < Rectify::Command
  attr_reader :book_id, :quantity
  def initialize(params)
    @book_id = params[:book_id].to_i
    @quantity = params[:quantity].to_i
  end

  def call
    return broadcast(:invalid) unless @book_id && @quantity
    transaction do
      add_item_to_order
    end
    broadcast :ok
  end

  private

  def add_item_to_order
    current_order.add_item(@book_id, @quantity)
    current_order.save
  end

end