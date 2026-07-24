labels = [0,1,2,3,7,12,18,11,19,5,15,4]
tree_edges = [[0,1],[0,2],[0,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11]]
raise "labels" unless labels.uniq.length == 12
lengths = tree_edges.map { |u,v| d=(labels[u]-labels[v]).abs; [d,23-d].min }.uniq.sort
raise "lengths" unless lengths == (1..11).to_a
edges = (0...23).flat_map { |i| tree_edges.map { |u,v| [(labels[u]+i)%23,(labels[v]+i)%23].sort } }.uniq
expected = (0...23).flat_map { |i| ((i+1)...23).map { |j| [i,j] } }.sort
raise "coverage" unless edges.length == 253 && edges.sort == expected
puts({shifts: 23, edges: 253, status: "PASS"})
