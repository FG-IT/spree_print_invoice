module Invoice::OrdersControllerDecorator
  def self.prepended(base)
    base.before_action :load_order, only: [:invoice]
  end
  def invoice
    @bookkeeping_document = @order.packaging_slip;
    respond_with(@bookkeeping_document) do |format|
      format.pdf do
        send_data @bookkeeping_document.pdf, type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  private

  def order_focused?
    params[:id].present?
  end

  def load_order
    @order = Spree::Order.find_by(number: params[:id])
  end

end

::Spree::OrdersController.prepend(Invoice::OrdersControllerDecorator)

