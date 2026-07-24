#!/usr/bin/env ruby
dem={"t1"=>15,"t2"=>10,"t3"=>15}; dmax=15
e={%w[s t1]=>[10,2],%w[s t2]=>[6,3],%w[s u]=>[24,0],%w[u t3]=>[10,2],%w[u v]=>[14,0],%w[v t1]=>[5,0],%w[v w]=>[9,0],%w[w t2]=>[4,0],%w[w t3]=>[5,0]}
p={"t1"=>[[%w[s t1]], [%w[s u],%w[u v],%w[v t1]]],"t2"=>[[%w[s t2]], [%w[s u],%w[u v],%w[v w],%w[w t2]]],"t3"=>[[%w[s u],%w[u t3]], [%w[s u],%w[u v],%w[v w],%w[w t3]]]}
raise unless e.values.sum(&:first)==87 && e[%w[s t1]][0]+e[%w[s t2]][0]+e[%w[s u]][0]==40
raise unless e.values.each_with_index.sum{|v,i|v[0]*e.values[i][1]}==58
rows=[]
[0,1].repeated_permutation(3).each do |ch|
 load=Hash.new(0); total=0
 ["t1","t2","t3"].each_with_index do |t,i|
  p[t][ch[i]].each{|a|load[a]+=dem[t]}; total+=dem[t]*p[t][ch[i]].sum{|a|e[a][1]}
 end
 bad=load.each_with_object({}){|(a,v),h|h[a]=v-e[a][0]-dmax if v>e[a][0]+dmax}; rows << [ch,total,bad.empty?,bad]
end
raise unless rows.size==8 && rows.count{|r|r[2]}==4 && rows.select{|r|r[2]}.all?{|r|r[1]>=60}
puts "DGG/Goemans finite counterexample Ruby replay PASS"; rows.each{|r|p r}
