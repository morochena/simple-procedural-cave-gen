
Random.new_seed

width = 100
height = 100
border = 2
kill_no = 6
spawn_prob = 0.6
cell_kill_no = 6


# generate the map
map = []

(0..width).each do |x|
  map[x] = []
  (0..height).each do |y|
    map[x][y] = '#'
  end
end

# create miner

miners = []

miners.push({
  x: rand(border..(width-border)),
  y: rand(border..(height-border))
})

# mining

while !miners.empty? do 
miners.reverse.each do |miner|
  empty = 0
  (-1..1).each do |x|
    (-1..1).each do |y|
      if ((map[miner[:x]+x][miner[:y]+y] == '.') ||
          (miner[:x]+x < border || miner[:x]+x > width-border) ||
          (miner[:y]+y < border || miner[:y]+y > height-border))
        empty += 1;
      end
    end
  end

  if empty >= kill_no
    miners.delete(miner)
  else
    if rand <= spawn_prob
      miners.push({
        x: miner[:x],
        y: miner[:y]
      })
    end

    x_dir, y_dir = rand(-1..1), rand(-1..1)

    if ((miner[:x]+x_dir >= border && miner[:x]+x_dir <= width-border) &&
        (miner[:y]+y_dir >= border && miner[:y]+y_dir <= height-border))

      miner[:x] = miner[:x] + x_dir
      miner[:y] = miner[:y] + y_dir
    end

    map[miner[:x]][miner[:y]] = '.'

  end

end
end


(border..map.size-(border+1)).each do |x|
  (border..map[x].size-(border+1)).each do |y|
    empty = 0
    (-1..1).each do |d_x|
      (-1..1).each do |d_y|
        if map[x+d_x][y+d_y] == '.'
          empty = empty + 1
        end
      end
    end

    if empty >= cell_kill_no
      map[x][y] = '.'
    end
  end
end

map.each { |x|
  puts x.join("")
}
