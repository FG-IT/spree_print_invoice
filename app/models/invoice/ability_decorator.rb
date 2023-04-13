module Invoice::AbilityDecorator
  protected

  def abilities_to_register
    super << ::Spree::InvoiceAbility
  end
end

::Spree::Ability.prepend ::Invoice::AbilityDecorator