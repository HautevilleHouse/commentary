require 'set'
N = 9
tree = [[0,1],[0,2],[0,3],[3,4]]
base = {0=>0, 1=>1, 2=>2, 3=>3, 4=>7}
edge = lambda { |a,b| [a % N, b % N].sort }
all_edges = (0...N).to_a.combination(2).map(&:sort).to_set
shifted = Set.new
(0...N).each do |i|
  current = tree.map { |u,v| edge.call(base[u] + i, base[v] + i) }.to_set
  raise unless current.length == 4 && shifted.disjoint?(current)
  shifted.merge(current)
end
raise unless shifted.length == 36 && shifted == all_edges
puts 'PASS: 9 cyclic shifts; 36 distinct edges; exact K9 coverage'
