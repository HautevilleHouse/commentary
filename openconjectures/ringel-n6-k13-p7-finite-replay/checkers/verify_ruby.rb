base = [0, 1, 3, 6, 10, 2, 8]
paths = (0...13).map { |i| base.map { |x| (i + x) % 13 } }
edges = paths.flat_map { |p| (0...6).map { |j| [p[j], p[j + 1]].sort } }
raise "vertices" unless paths.all? { |p| p.uniq.length == 7 }
raise "edges" unless edges.length == 78 && edges.uniq.length == 78
expected = (0...13).flat_map { |i| ((i + 1)...13).map { |j| [i, j] } }
raise "coverage" unless edges.sort == expected.sort
puts({paths: 13, edges: 78, status: "PASS"})
