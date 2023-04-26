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
        send_data @bookkeeping_document.pdf, type: 'application/pdf', disposition: 'attachment', filename: "Invoice #{@bookkeeping_document.number}.pdf"
      end
    end
  end

  private

  def check_authorization
    order = ::Spree::Order.find_by(number: params[:id]) if params[:id].present?
    order ||= current_order

    if order && (action_name.to_sym == :show || action_name.to_sym == :invoice)
      authorize! :show, order, cookies.signed[:token]
    elsif order
      authorize! :edit, order, cookies.signed[:token]
    else
      authorize! :create, ::Spree::Order
    end
  end

  def load_order
    @order = ::Spree::Order.find_by(number: params[:id])
  end
end

::Spree::OrdersController.prepend(::Invoice::OrdersControllerDecorator)
