require 'set'
n=27
tree=[[0,1],[0,2],[0,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11],[11,12],[12,13]]
base={0=>0,1=>1,2=>2,3=>3,4=>7,5=>12,6=>18,7=>25,8=>6,9=>15,10=>5,11=>16,12=>4,13=>17}
edge=->(a,b){[a%n,b%n].sort}
all_edges=(0...n).to_a.combination(2).map(&:sort).to_set
covered=Set.new
(0...n).each do |i|
  current=tree.map{|u,v|edge.call(base[u]+i,base[v]+i)}.to_set
  raise unless current.length==13 && covered.disjoint?(current)
  covered.merge(current)
end
raise unless covered==all_edges && covered.length==351
puts 'PASS: 27 cyclic shifts; 351 distinct edges; exact K27 coverage'
