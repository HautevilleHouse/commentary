X = [0, 1, 2, 3]
values = Hash.new(0)
[[0,1],[2,3]].each { |p| values[p] = 1 }
[[0,2],[1,3]].each { |p| values[p] = 2 }
[[0,3],[1,2]].each { |p| values[p] = 3 }

subsets = (0..4).flat_map { |k| X.combination(k).map(&:to_a) }
cover = lambda do |threshold|
  X.combination(threshold).all? do |target|
    got = subsets.select { |s| (s - target).empty? }.map { |s| values[s] }.uniq
    got.sort == X
  end
end
raise 'm=2 unexpectedly works' if cover.call(2)
raise 'm=3 failed' unless cover.call(3)
raise 'm=4 failed' unless cover.call(4)
puts 'H(4)=3; m0/m1/m2 lower bound; m3 construction passes 5 triples'
