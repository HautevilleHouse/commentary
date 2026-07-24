require 'set'
n=23
tree=[[0,1],[0,2],[0,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11]]
base={0=>11,1=>20,2=>21,3=>0,4=>1,5=>3,6=>6,7=>10,8=>15,9=>9,10=>16,11=>8}
edge=->(a,b){[a%n,b%n].sort}
all_edges=(0...n).to_a.combination(2).map(&:sort).to_set
covered=Set.new
(0...n).each do |i|
  current=tree.map{|u,v|edge.call(base[u]+i,base[v]+i)}.to_set
  raise unless current.length==11 && covered.disjoint?(current)
  covered.merge(current)
end
raise unless covered==all_edges && covered.length==253
puts 'PASS: 23 cyclic shifts; 253 distinct edges; exact K23 coverage'
