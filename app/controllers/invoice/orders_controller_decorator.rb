module Invoice::OrdersControllerDecorator
  def invoice
    load_order

    if @order.blank? || !@order.completed?
      redirect_back fallback_location: '/'

      return
    end

    @bookkeeping_document = @order.packaging_slip;
    if @bookkeeping_document.blank?
      @bookkeeping_document = @order.invoice_for_order
    end

    respond_with(@bookkeeping_document) do |format|
      format.pdf do
        send_data @bookkeeping_document.pdf, type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  private

  def load_order
    @order = ::Spree::Order.find_by(number: params[:id])
  end
end

::Spree::OrdersController.prepend(Invoice::OrdersControllerDecorator)
