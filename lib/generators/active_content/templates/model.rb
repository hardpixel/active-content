class <%= model_class %> < ActiveContent::<%= type_class %>
  <%- model_meta.each do |metum| -%>
  has_meta <%= metum %>
  <%- end -%>
end
