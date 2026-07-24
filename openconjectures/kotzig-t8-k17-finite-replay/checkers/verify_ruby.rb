labels = [0,8,7,6,1,5,2,4,3]
tree_edges = [[0,1],[0,2],[0,3],[3,4],[4,5],[5,6],[6,7],[7,8]]
raise "labels" unless labels.uniq.length == 9
lengths = tree_edges.map { |u,v| d=(labels[u]-labels[v]).abs; [d,17-d].min }.uniq.sort
raise "lengths" unless lengths == (1..8).to_a
edges = (0...17).flat_map { |i| tree_edges.map { |u,v| [(labels[u]+i)%17,(labels[v]+i)%17].sort } }.uniq
expected = (0...17).flat_map { |i| ((i+1)...17).map { |j| [i,j] } }.sort
raise "coverage" unless edges.length == 136 && edges.sort == expected
puts({shifts: 17, edges: 136, status: "PASS"})
