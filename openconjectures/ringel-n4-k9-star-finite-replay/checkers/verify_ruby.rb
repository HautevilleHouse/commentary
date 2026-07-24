stars = (0...9).map { |i| (1..4).map { |d| [i, (i + d) % 9].sort } }
edges = stars.flatten(1)
raise "edge count" unless edges.length == 36
raise "duplicate" unless edges.uniq.length == 36
expected = (0...9).flat_map { |i| ((i + 1)...9).map { |j| [i, j] } }
raise "coverage" unless edges.sort == expected.sort
puts({stars: 9, edges: 36, status: "PASS"})
