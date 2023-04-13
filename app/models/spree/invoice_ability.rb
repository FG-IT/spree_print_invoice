class Spree::InvoiceAbility
  include ::CanCan::Ability

  def initialize(user)
    apply_invoice_permission(user)
  end

  protected

  def apply_invoice_permission(user)
    can [:invoice], ::Spree::Order do |order, token|
      order.completed? && (order.user == user || order.token && token == order.token)
    end
  end
end
