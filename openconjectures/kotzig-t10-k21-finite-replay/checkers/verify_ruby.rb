labels = [0,9,8,10,3,18,13,17,20,1,2]
tree_edges = [[0,1],[0,2],[0,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10]]
raise "labels" unless labels.uniq.length == 11
lengths = tree_edges.map { |u,v| d=(labels[u]-labels[v]).abs; [d,21-d].min }.uniq.sort
raise "lengths" unless lengths == (1..10).to_a
edges = (0...21).flat_map { |i| tree_edges.map { |u,v| [(labels[u]+i)%21,(labels[v]+i)%21].sort } }.uniq
expected = (0...21).flat_map { |i| ((i+1)...21).map { |j| [i,j] } }.sort
raise "coverage" unless edges.length == 210 && edges.sort == expected
puts({shifts: 21, edges: 210, status: "PASS"})
