require 'set'
n=25
tree=[[0,1],[0,2],[0,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11],[11,12]]
base={0=>0,1=>11,2=>13,3=>1,4=>24,5=>2,6=>23,7=>3,8=>22,9=>4,10=>21,11=>5,12=>20}
edge=->(a,b){[a%n,b%n].sort}
all_edges=(0...n).to_a.combination(2).map(&:sort).to_set
covered=Set.new
(0...n).each do |i|
  current=tree.map{|u,v|edge.call(base[u]+i,base[v]+i)}.to_set
  raise unless current.length==12 && covered.disjoint?(current)
  covered.merge(current)
end
raise unless covered==all_edges && covered.length==300
puts 'PASS: 25 cyclic shifts; 300 distinct edges; exact K25 coverage'
