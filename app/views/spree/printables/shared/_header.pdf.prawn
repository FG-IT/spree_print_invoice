im = (Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)).find_asset(Spree::PrintInvoice::Config[:logo_path])

if im && File.exist?(im.pathname)
  pdf.image im.filename, vposition: :top, height: 15, scale: Spree::PrintInvoice::Config[:logo_scale]
end

pdf.move_down 8 
pdf.text ::Spree::Store.last&.name, style: :bold, size: 12

pdf.move_down 2 
address = ::Spree::Store.last&.address
address.gsub!(/[\r\n]+/, ', ')
pdf.text address

pdf.move_down 2 
pdf.text ::Spree::Store.last&.contact_phone

pdf.grid([0,3], [1,4]).bounding_box do
  pdf.text Spree.t(printable.document_type, scope: :print_invoice), align: :right, style: :bold, size: 18
  pdf.move_down 4

  pdf.text Spree.t(:invoice_number, scope: :print_invoice, number: printable.number), align: :right
  pdf.move_down 2
  pdf.text Spree.t(:invoice_date, scope: :print_invoice, date: I18n.l(printable.order_date)), align: :right
end
