# Sample typed field definitions for the Product model.
# Idempotent: safe to re-run.

return if TypedFields::Field::Base.where(entity_type: "Product").exists?

TypedFields::Field::Text.create!(
  name: "sku",
  entity_type: "Product",
  required: true,
  sort_order: 1
)

TypedFields::Field::Decimal.create!(
  name: "price",
  entity_type: "Product",
  required: true,
  sort_order: 2,
  options: { min: 0 }
)

TypedFields::Field::Integer.create!(
  name: "stock_quantity",
  entity_type: "Product",
  sort_order: 3,
  options: { min: 0 }
)

TypedFields::Field::Boolean.create!(
  name: "featured",
  entity_type: "Product",
  sort_order: 4
)

category = TypedFields::Field::Select.create!(
  name: "category",
  entity_type: "Product",
  sort_order: 5
)
category.field_options.create!([
  { label: "Apparel",     value: "apparel",     sort_order: 1 },
  { label: "Electronics", value: "electronics", sort_order: 2 },
  { label: "Home Goods",  value: "home_goods",  sort_order: 3 },
])

puts "Seeded #{TypedFields::Field::Base.where(entity_type: 'Product').count} typed fields for Product."
