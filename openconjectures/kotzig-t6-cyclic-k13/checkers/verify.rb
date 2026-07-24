require 'set'
n=13
tree=[[0,1],[0,2],[0,3],[3,4],[4,5],[5,6]]
base={0=>2,1=>3,2=>4,3=>5,4=>1,5=>6,6=>0}
edge=->(a,b){[a%n,b%n].sort}
all_edges=(0...n).to_a.combination(2).map(&:sort).to_set
covered=Set.new
(0...n).each do |i|
  current=tree.map{|u,v|edge.call(base[u]+i,base[v]+i)}.to_set
  raise unless current.length==6 && covered.disjoint?(current)
  covered.merge(current)
end
raise unless covered==all_edges && covered.length==78
puts 'PASS: 13 cyclic shifts; 78 distinct edges; exact K13 coverage'
