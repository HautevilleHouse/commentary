base = [0, 2, 3, 6, 1]
paths = (0...9).map { |i| base.map { |x| (i + x) % 9 } }
edges = paths.flat_map { |p| (0...4).map { |j| [p[j], p[j + 1]].sort } }
raise "vertices" unless paths.all? { |p| p.uniq.length == 5 }
raise "edges" unless edges.length == 36 && edges.uniq.length == 36
expected = (0...9).flat_map { |i| ((i + 1)...9).map { |j| [i, j] } }
raise "coverage" unless edges.sort == expected.sort
puts({paths: 9, edges: 36, status: "PASS"})
