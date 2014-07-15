BACKSTAGE_PASSES_NAME = 'Backstage passes to a TAFKAL80ETC concert'

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
  item.name == 'Aged Brie' || item.name == 'Backstage passes to a TAFKAL80ETC concert'
end

def update_quality_for_antique(item)
  if item.quality < 50
    item.quality += 1
    if item.name == BACKSTAGE_PASSES_NAME
      update_quality_for_backstage_passes(item)
    end
  end
end

def update_quality_for_backstage_passes(item)
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

def update_quality_for_item(item)
  if item.quality > 0
    if item.name != 'Sulfuras, Hand of Ragnaros'
      item.quality -= 1
    end
  end
end

def update_sell_in_for(item)
  if item.name != 'Sulfuras, Hand of Ragnaros'
    item.sell_in -= 1
  end
  check_sell_in_constraints_for(item)
end

def check_sell_in_constraints_for(item)
  if item.sell_in < 0
    if item.name != "Aged Brie"
      if item.name != 'Backstage passes to a TAFKAL80ETC concert'
        if item.quality > 0
          if item.name != 'Sulfuras, Hand of Ragnaros'
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

