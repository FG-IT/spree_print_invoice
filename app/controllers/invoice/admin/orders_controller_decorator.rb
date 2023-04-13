module Invoice::Admin::OrdersControllerDecorator
  def invoice
    load_order

    unless @order.completed?
      redirect_back fallback_location: spree.admin_order_url(@order)

      return
    end

    @bookkeeping_document = @order.packaging_slip
    if @bookkeeping_document.blank?
      @bookkeeping_document = @order.invoice_for_order
    end

    respond_with(@bookkeeping_document) do |format|
      format.pdf do
        send_data @bookkeeping_document.pdf, type: 'application/pdf', disposition: 'inline'
      end
    end
  end
end

::Spree::Admin::OrdersController.prepend(Invoice::Admin::OrdersControllerDecorator)

