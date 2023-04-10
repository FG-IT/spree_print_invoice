header = [
  pdf.make_cell(content: Spree.t(:item_index)),
  pdf.make_cell(content: Spree.t(:item_description)),
  pdf.make_cell(content: Spree.t(:price)),
  pdf.make_cell(content: Spree.t(:qty)),
  pdf.make_cell(content: Spree.t(:total))
]
data = [header]

invoice.items.each_with_index do |item, index|
  row = [
		index + 1,
    item.name,
    item.display_price.to_s,
    item.quantity,
    item.display_total.to_s
  ]
  data += [row]
end

column_widths = [0.075, 0.61, 0.12, 0.075, 0.12].map { |w| w * pdf.bounds.width }

pdf.table(data, header: true, position: :center, column_widths: column_widths, cell_style: { borders: [] }) do 
  row(0).style align: :center, font_style: :bold, background_color: 'CCCCCC'
  column(0..2).style align: :left
  column(3..6).style align: :right
end

