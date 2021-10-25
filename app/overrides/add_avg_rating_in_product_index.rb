Deface::Override.new(
  virtual_path: 'spree/admin/products/index',
  name: 'add_avg_rating_heading_in_product_index',
  insert_before: '[data-hook="admin_products_index_header_actions"]',
  text: <<-HTML
  		<th scope="col" class="text-center"><%= Spree.t(:avg_rating) %></th>
  HTML
)

Deface::Override.new(
  virtual_path: 'spree/admin/products/index',
  name: 'add_avg_rating_value_in_product_index',
  insert_before: '[data-hook="admin_products_index_row_actions"]',
  text: <<-HTML
  		<td class="text-center"><%= product.avg_rating %></td>
  HTML
)
