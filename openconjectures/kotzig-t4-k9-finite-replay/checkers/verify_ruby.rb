base = {0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 7}
tree_edges = [[0, 1], [0, 2], [0, 3], [3, 4]]
edges = (0...9).flat_map { |i| tree_edges.map { |u, v| [(base[u] + i) % 9, (base[v] + i) % 9].sort } }.uniq
expected = (0...9).flat_map { |i| ((i + 1)...9).map { |j| [i, j] } }.sort
raise "coverage" unless edges.length == 36 && edges.sort == expected
puts({shifts: 9, edges: 36, status: "PASS"})
