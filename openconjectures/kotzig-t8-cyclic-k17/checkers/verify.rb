require 'set'
n=17
tree=[[0,1],[0,2],[0,3],[3,4],[4,5],[5,6],[6,7],[7,8]]
base={0=>0,1=>1,2=>2,3=>3,4=>7,5=>12,6=>6,7=>13,8=>4}
edge=->(a,b){[a%n,b%n].sort}
all_edges=(0...n).to_a.combination(2).map(&:sort).to_set
covered=Set.new
(0...n).each do |i|
  current=tree.map{|u,v|edge.call(base[u]+i,base[v]+i)}.to_set
  raise unless current.length==8 && covered.disjoint?(current)
  covered.merge(current)
end
raise unless covered==all_edges && covered.length==136
puts 'PASS: 17 cyclic shifts; 136 distinct edges; exact K17 coverage'
