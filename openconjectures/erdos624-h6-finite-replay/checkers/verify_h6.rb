X = (0...6).to_a
vals = [3,2,2,1,0,4,1,0,4,4,1,0,0,1,0,4,4,0,2,2] + [5] * 44
subs = (0..6).flat_map { |k| X.combination(k).map(&:to_a) }
raise 'wrong table length' unless vals.length == 64
v = subs.zip(vals).to_h
cover = lambda do |threshold|
  X.combination(threshold).all? do |target|
    got = subs.select { |s| (s - target).empty? }.map { |s| v[s] }.uniq
    got.sort == X
  end
end
raise 'm=3 failed' unless cover.call(3)
raise 'm=4 failed' unless cover.call(4)
raise 'm=5 failed' unless cover.call(5)
raise 'm=6 failed' unless cover.call(6)
puts 'H(6)=3; m0/m1/m2 cardinality lower bound; m3-m6 construction passes'
