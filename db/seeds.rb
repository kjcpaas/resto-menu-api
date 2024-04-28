Menu.destroy_all
Section.destroy_all
ModifierGroup.destroy_all
Item.destroy_all

menu = Menu.create!(
  label: "Sakura Blossoms Delights",
  state: "active",
  start_date: "2024-03-15",
  end_date: "2024-04-30",
)

# Section 1: Chef's Table
# Not configurable as it's chef's choice
section1 = Section.create!(
  label: "Chef's Table",
  description: "Savor an exquisite culinary journey crafted by Chef Hiroshi, our Michelin-starred maestro, at the exclusive Chef's Table."
)

MenuSection.create!(
  menu: menu,
  section: section1,
  display_order: 0
)
omakase = Item.create!(
  type: "Product",
  label: "Sakura Symphony Omakase",
  description: "Discover the art of Omakase with our Sakura Symphony, curated by Chef Hiroshi, where you entrust the chef to craft a bespoke dining experience, guiding you through the essence of cherry blossoms with each exquisite dish.",
  price: 150.0
)
SectionItem.create!(
  section: section1,
  item: omakase,
  display_order: 0
)

# Section 2
section2 = Section.create!(
  label: "Drinks",
  description: "Elevate your dining experience with carefully curated beverages to complement your Omakase journey."
)
MenuSection.create!(
  menu_id: menu.identifier,
  section_id: section2.identifier,
  display_order: 1
)

# Tea
tea = Item.create!(
  type: "Product",
  label: "Sakura Blossom Tea",
  description: "Fragrant green tea infused with cherry blossoms, served hot or cold.",
  price: 8
)
hot_tea = Item.create!(
  type: "Component",
  label: "Oyu (Hot)",
  description: "Indulge in the comforting warmth of fragrant green tea infused with delicate cherry blossoms, offering a soothing accompaniment to your meal.",
  price: 8
)
cold_tea = Item.create!(
  type: "Component",
  label: "Hiya (Cold)",
  description: "Refresh your palate with the crisp and invigorating flavors of chilled green tea infused with delicate cherry blossoms, perfect for enjoying on a warm day.",
  price: 8
)
SectionItem.create!(
  section: section2,
  item: tea,
  display_order: 0
)
tea_temp = ModifierGroup.create!(
  label: "How would you like your tea?",
  selection_required_min: 1,
  selection_required_max: 99
)
ItemModifierGroup.create!(
  item: tea,
  modifier_group: tea_temp
)
Modifier.create!(
  item: hot_tea,
  modifier_group: tea_temp,
  display_order: 0,
  default_quantity: 1
)
Modifier.create!(
  item: cold_tea,
  modifier_group: tea_temp,
  display_order: 1,
  default_quantity: 0
)

# Sake
sake = Item.create!(
  type: "Product",
  label: "Sakura Sake",
  description: "Premium sake infused with cherry blossom petals.",
  price: 12
)
small_sake = Item.create!(
  type: "Component",
  label: "Tokkuri (Small Flask)",
  description: "A single-serving flask of premium sake infused with the essence of cherry blossoms, perfect for savoring the flavors of the season.",
  price: 12
)
medium_sake = Item.create!(
  type: "Component",
  label: "Chokkari (Medium Flask)",
  description: "A medium-sized flask of premium sake, ideal for sharing and enhancing the culinary journey with friends or loved ones.",
  price: 18
)
large_sake = Item.create!(
  type: "Component",
  label: "Otokka (Large Flask)",
  description: "A generous flask of premium sake, symbolizing celebration and joy, to elevate your dining experience to new heights.",
  price: 25
)
SectionItem.create!(
  section: section2,
  item: sake,
  display_order: 1
)
sake_size = ModifierGroup.create!(
  label: "How much sake do you want?",
  selection_required_min: 1,
  # Make sure the guest doesn't get too drunk.
  selection_required_max: 10
)
ItemModifierGroup.create!(
  item: sake,
  modifier_group: sake_size
)
Modifier.create!({
  item: small_sake,
  modifier_group: sake_size,
  display_order: 0,
  default_quantity: 1
},{
  item: medium_sake,
  modifier_group: sake_size,
  display_order: 1,
  default_quantity: 0
},{
  item: large_sake,
  modifier_group: sake_size,
  display_order: 2,
  default_quantity: 0
})
