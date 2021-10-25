Deface::Override.new(
  virtual_path: 'spree/admin/products/edit',
  name: 'add_avg_rating_in_product_edit',
  insert_after: 'erb[silent]:contains(":page_actions")',
  text: <<-HTML
  		<h5 style="padding-top:10px;">Avg Rating: <%=@product.avg_rating %></h5>&nbsp;
  HTML
)
