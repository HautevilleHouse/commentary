p=7;e=(0...p).flat_map{|a|(0...p).map{|b|[a,b]}}
add=->(x,y){[(x[0]+y[0])%p,(x[1]+y[1])%p]};mul=->(x,y){[(x[0]*y[0]+3*x[1]*y[1])%p,(x[0]*y[1]+x[1]*y[0])%p]};pw=->(x,n){r=[1,0];n.times{r=mul.call(r,x)};r}
ad=bad=0;e.each{|b|e.each{|c|next if pw.call(b,7)==c;e.each{|d|ad+=1;out=e.map{|x|add.call(add.call(add.call(pw.call(x,8),mul.call(b,pw.call(x,7))),mul.call(c,x)),d)};bad+=1 if out.uniq.length==49}}}
raise unless ad==115248&&bad==0
puts "#{ad} #{bad}"
