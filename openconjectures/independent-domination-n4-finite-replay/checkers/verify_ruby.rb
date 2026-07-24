N=4
edges=(0...N).to_a.combination(2).to_a
def check(mask, edges)
  adj=Array.new(4){Array.new(4,false)}
  edges.each_with_index{|(u,v),i| adj[u][v]=adj[v][u]=true if (mask>>i)&1==1}
  deg=adj.map{|row| row.count(true)}
  return nil if deg.min==0
  d=deg.max; best=5
  (1...16).each do |s|
    next if s.digits(2).sum>=best
    next if edges.any?{|u,v| ((s>>u)&1)==1 && ((s>>v)&1)==1 && adj[u][v]}
    next unless (0...4).all?{|v| ((s>>v)&1)==1 || (0...4).any?{|u| ((s>>u)&1)==1 && adj[u][v]}}
    best=s.digits(2).sum
  end
  lhs=d.even? ? (d+2)**2*best : (d+1)*(d+3)*best
  rhs=d.even? ? (d*d+4)*4 : (d*d+3)*4
  [d,best,lhs<=rhs]
end
rows=(0...64).each_with_object([]){|m,a| r=check(m,edges); a << [m,r] if r}
bad=rows.each_with_object([]){|pair,a| a << pair[0] unless pair[1][2]}
raise unless rows.length==41 && bad.empty?
puts "graphs=#{rows.length} violating_masks=#{bad}"
