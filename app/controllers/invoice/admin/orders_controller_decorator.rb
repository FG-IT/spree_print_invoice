module Invoice::Admin::OrdersControllerDecorator
  def invoice
    load_order
    @bookkeeping_document = @order.packaging_slip
    respond_with(@bookkeeping_document) do |format|
      format.pdf do
        send_data @bookkeeping_document.pdf, type: 'application/pdf', disposition: 'inline'
      end
    end
  end
end

::Spree::Admin::OrdersController.prepend(Invoice::Admin::OrdersControllerDecorator)

