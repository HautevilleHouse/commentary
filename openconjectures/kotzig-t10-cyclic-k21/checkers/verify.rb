require 'set'
n=21
tree=[[0,1],[0,2],[0,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10]]
base={0=>0,1=>9,2=>10,3=>8,4=>1,5=>7,6=>2,7=>6,8=>3,9=>5,10=>4}
edge=->(a,b){[a%n,b%n].sort}
all_edges=(0...n).to_a.combination(2).map(&:sort).to_set
covered=Set.new
(0...n).each do |i|
  current=tree.map{|u,v|edge.call(base[u]+i,base[v]+i)}.to_set
  raise unless current.length==10 && covered.disjoint?(current)
  covered.merge(current)
end
raise unless covered==all_edges && covered.length==210
puts 'PASS: 21 cyclic shifts; 210 distinct edges; exact K21 coverage'
