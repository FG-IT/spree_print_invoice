# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/admin/shared/_order_tabs',
  name: 'print_invoice_order_tab_links',
  insert_bottom: '[data-hook="admin_order_tabs"]',
  partial: 'spree/admin/orders/print_invoice_order_tab_links'
)

Deface::Override.new(
  virtual_path: 'spree/admin/shared/_content_header',
  name: 'print_invoice_order_button',
  insert_bottom: '[data-hook="toolbar"]',
  partial: 'spree/admin/orders/print_invoice_order_tab_buttons'
)

