module Spree
    class Printables::Order::ShipmentView < Printables::Invoice::BaseView
      def_delegators :@printable,
                     :email,
                     :bill_address,
                     :ship_address,
                     :tax_address,
                     :item_total,
                     :total,
                     :order_date,
                     :payments,
                     :shipments
  
      def items
        printable.line_items.map do |item|
          Spree::Printables::Invoice::Item.new(
              sku: item.variant.sku,
              name: item.variant.name,
              options_text: item.variant.options_text,
              price: item.price,
              quantity: item.quantity,
              total: item.total
          )
        end
      end

      def shipments
        printable.shipments.map do |item|
          Spree::Printables::Invoice::Item.new(
            number: item.number,
            carrier: item.carrier,
            tracking: item.tracking,
            updated_at: item.updated_at
          )
        end
      end

      def firstname
        printable.tax_address.firstname
      end
  
      def order_date
        printable.order_date
      end
  
      def lastname
        printable.tax_address.lastname
      end
  
      private
  
      def all_adjustments
        printable.all_adjustments.eligible
      end
    end
  end
  