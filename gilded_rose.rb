AGED_BRIE_NAME = 'Aged Brie'
BACKSTAGE_PASSES_NAME = 'Backstage passes to a TAFKAL80ETC concert'
SULFURAS_NAME = 'Sulfuras, Hand of Ragnaros'

def update_quality(items)
  items.each do |item|
    if item.name == AGED_BRIE_NAME || item.name == BACKSTAGE_PASSES_NAME
      update_quality_for_antique(item)
    else
      update_quality_for_item(item)
    end
    if item.name != SULFURAS_NAME
      item.sell_in -= 1
    end
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != BACKSTAGE_PASSES_NAME
          if item.quality > 0
            if item.name != SULFURAS_NAME
              item.quality -= 1
            end
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        if item.quality < 50
          item.quality += 1
        end
      end
    end
  end
end

def update_quality_for_antique(item)
  if item.quality < 50
    item.quality += 1
    if item.name == BACKSTAGE_PASSES_NAME
      if item.sell_in < 11
        if item.quality < 50
          item.quality += 1
        end
      end
      if item.sell_in < 6
        if item.quality < 50
          item.quality += 1
        end
      end
    end
  end
end

def update_quality_for_item(item)
  item.quality -= 1 if item.quality > 0 && item.name != SULFURAS_NAME
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

