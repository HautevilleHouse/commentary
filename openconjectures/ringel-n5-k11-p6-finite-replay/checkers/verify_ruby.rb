paths = (0...11).map { |i| [0, 5, 1, 4, 2, 3].map { |x| (i + x) % 11 } }
edges = paths.flat_map { |p| (0...5).map { |j| [p[j], p[j + 1]].sort } }
raise "vertices" unless paths.all? { |p| p.uniq.length == 6 }
raise "edges" unless edges.length == 55 && edges.uniq.length == 55
expected = (0...11).flat_map { |i| ((i + 1)...11).map { |j| [i, j] } }
raise "coverage" unless edges.sort == expected.sort
puts({paths: 11, edges: 55, status: "PASS"})
