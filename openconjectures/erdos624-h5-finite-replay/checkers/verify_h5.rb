X = [0, 1, 2, 3, 4]
v = { [] => 0, [0] => 1, [1] => 2, [2] => 1, [3] => 2, [4] => 3,
      [0,1] => 1, [0,2] => 2, [0,3] => 3, [0,4] => 4,
      [1,2] => 3, [1,3] => 1, [1,4] => 4,
      [2,3] => 4, [2,4] => 4, [3,4] => 4 }
subsets = (0..5).flat_map { |k| X.combination(k).map(&:to_a) }
subsets.each { |s| v[s] = 4 if s.length >= 3 }
raise 'incomplete table' unless v.length == 32
cover = lambda do |threshold|
  X.combination(threshold).all? do |target|
    got = subsets.select { |s| (s - target).empty? }.map { |s| v[s] }.uniq
    got.sort == X
  end
end
raise 'm=2 unexpectedly works' if cover.call(2)
raise 'm=3 failed' unless cover.call(3)
raise 'm=4 failed' unless cover.call(4)
raise 'm=5 failed' unless cover.call(5)
puts 'H(5)=3; m0/m1/m2 cardinality lower bound; m3-m5 construction passes'
