AGED_BRIE_NAME = 'Aged Brie'
BACKSTAGE_PASSES_NAME = 'Backstage passes to a TAFKAL80ETC concert'
SULFURAS_NAME = 'Sulfuras, Hand of Ragnaros'

def update_quality(items)
  items.each do |item|
    update_quality_for(item)
    update_sell_in_for(item)
  end
end

def update_quality_for(item)
  if older_is_better_for?(item)
    update_quality_for_antique(item)
  else
    update_quality_for_item(item)
  end
end

def older_is_better_for?(item)
  item.name == AGED_BRIE_NAME || item.name == BACKSTAGE_PASSES_NAME
end

def update_quality_for_antique(item)
  if item.quality < 50
    item.quality += 1
    update_quality_for_passes(item) if item.name == BACKSTAGE_PASSES_NAME
  end
end

def update_quality_for_passes(item)
  item.quality += 1 if item.sell_in < 11 && item.quality < 50
  item.quality += 1 if item.sell_in < 6 && item.quality < 50
end

def update_quality_for_item(item)
  item.quality -= 1 if item.quality > 0 && !legendary?(item)
end

def update_sell_in_for(item)
  unless legendary?(item)
    item.sell_in -= 1
  end
  if item.sell_in < 0
    if item.name != AGED_BRIE_NAME
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

def legendary?(item)
  item.name == SULFURAS_NAME
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

