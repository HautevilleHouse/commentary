def adj(mask, es, i, j); i, j = j, i if i > j; (mask & (1 << es.index([i, j]))) != 0; end
def connected(mask, n, es)
  seen = {0=>true}; stack=[0]
  until stack.empty?; v=stack.pop; (0...n).each{|w| if !seen[w] && adj(mask,es,v,w); seen[w]=true; stack << w; end}; end
  seen.length == n
end
def triangle_free(mask,n,es); (0...n).to_a.combination(3).all?{|a,b,c| !(adj(mask,es,a,b)&&adj(mask,es,b,c)&&adj(mask,es,a,c))}; end
def total(mask,n,es,s); (0...n).all?{|v| (0...n).any?{|w| w!=v && s.include?(w) && adj(mask,es,v,w)}}; end
def subsets(a,r); a.combination(r).to_a; end
def path_size(mask,n,es)
  best=0
  (1..n).each do |r|; subsets((0...n).to_a,r).each do |s|
    ee=s.combination(2).select{|a,b| adj(mask,es,a,b)}; next unless ee.length==r-1
    deg=Hash.new(0); ee.each{|a,b|deg[a]+=1;deg[b]+=1}; next if deg.values.max.to_i>2
    seen={s[0]=>true}; st=[s[0]]; until st.empty?; v=st.pop; s.each{|w| k=[v,w].min; l=[v,w].max; if !seen[w]&&ee.include?([k,l]);seen[w]=true;st<<w;end};end
    best=r if seen.length==r
  end; end; best
end
counts={}; bad=0
(2..5).each do |n|
  es=(0...n).flat_map{|i|((i+1)...n).map{|j|[i,j]}}; retained=0
  (0...(1<<es.length)).each do |mask|; next unless connected(mask,n,es)&&triangle_free(mask,n,es)&&path_size(mask,n,es)<=4; retained+=1; sizes=[]
    (1..n).each{|r|subsets((0...n).to_a,r).each{|s| if total(mask,n,es,s)&&s.all?{|x| !total(mask,n,es,s-[x])};sizes<<r;end}}; bad+=1 if sizes.uniq.length>1
  end; counts[n]=retained
end
raise unless counts=={2=>1,3=>3,4=>19,5=>147}&&bad==0
puts "counts=#{counts} violations=#{bad}"
