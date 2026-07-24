require 'set'
n = 11
tree = [[0,1],[0,2],[0,3],[3,4],[4,5]]
base = {0=>0,1=>1,2=>2,3=>3,4=>10,5=>4}
edge = ->(a,b) { [a % n,b % n].sort }
all_edges = (0...n).to_a.combination(2).map(&:sort).to_set
covered = Set.new
(0...n).each do |i|
  current = tree.map { |u,v| edge.call(base[u]+i,base[v]+i) }.to_set
  raise unless current.length == 5 && covered.disjoint?(current)
  covered.merge(current)
end
raise unless covered == all_edges && covered.length == 55
puts 'PASS: 11 cyclic shifts; 55 distinct edges; exact K11 coverage'
