def mex(v); n=0; n+=1 while v.include?(n); n end
def opts(p); p.each_index.map { |i| (p[0...i] + p[(i+1)..].to_a).sort.reverse } end
def g(p,m={}); return 0 if p.empty?; m[p] ||= mex(opts(p).map{|q|g(q,m)}) end
def h(p,m={}); return 1 if p.empty?; m[p] ||= mex(opts(p).map{|q|h(q,m)}) end
raise unless opts([4,4]).all?{|q|q==[4]}
raise unless [g([],{}),h([],{}),g([4],{}),h([4],{}),g([4,4],{}),h([4,4],{})] == [0,1,1,0,0,1]
puts "CRIM [4,4]: pair=(0,1); states=[4,4]->[4]->[]"
