header =  [
  pdf.make_cell(content: 'Shipment ID'),
  pdf.make_cell(content: 'Tracking'),
  pdf.make_cell(content: 'Carrier'),
  pdf.make_cell(content: 'Shipment Date')
]
data = [header]

invoice.shipments.each do |item|
  row = [
    item.number,
    item.tracking,
    item.carrier,
    I18n.l(item.updated_at.to_date)
  ]
  data += [row]
end

column_widths = [0.225, 0.3, 0.3, 0.175].map { |w| w * pdf.bounds.width }

pdf.table(data, header: true, position: :center, column_widths: column_widths) do
  row(0).style align: :center, font_style: :bold
  column(0..2).style align: :left
  column(3).style align: :center
end
