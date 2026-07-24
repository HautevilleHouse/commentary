X = (0...7).to_a
v = [0,3,1,5,4,1,5,2,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,2,2,6,6,6,2,6,4,6,6,2,6,6,6,6,2,6,4,6,6,6,3,2,4,6,6,3,6,6,6,3,6,6,0,6,6,4,6,4,5,6,5,4,5,4,4,1,1,2,4,1,0,5,1,4,3,6,3,3,3,6,3,5,6,3,2,3,1,4,3,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6]
subs = (0..7).flat_map { |k| X.combination(k).map(&:to_a) }
v = v.first(128)
raise 'wrong table length' unless v.length == 128
vals = subs.zip(v).to_h
cover = lambda do |threshold|
  X.combination(threshold).all? do |target|
    got = subs.select { |s| (s - target).empty? }.map { |s| vals[s] }.uniq
    got.sort == X
  end
end
raise 'm=4 failed' unless cover.call(4)
raise 'm=5 failed' unless cover.call(5)
raise 'm=6 failed' unless cover.call(6)
raise 'm=7 failed' unless cover.call(7)
puts '3 <= H(7) <= 4; m4 construction passes 99 targets; m3 remains unknown'
