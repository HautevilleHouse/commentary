labels = [0,1,2,3,18,13,7,14,6,15]
tree_edges = [[0,1],[0,2],[0,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9]]
raise "labels" unless labels.uniq.length == 10
lengths = tree_edges.map { |u,v| d=(labels[u]-labels[v]).abs; [d,19-d].min }.uniq.sort
raise "lengths" unless lengths == (1..9).to_a
edges = (0...19).flat_map { |i| tree_edges.map { |u,v| [(labels[u]+i)%19,(labels[v]+i)%19].sort } }.uniq
expected = (0...19).flat_map { |i| ((i+1)...19).map { |j| [i,j] } }.sort
raise "coverage" unless edges.length == 171 && edges.sort == expected
puts({shifts: 19, edges: 171, status: "PASS"})
