p=5;e=(0...p).flat_map{|a|(0...p).map{|b|[a,b]}}
add=->(x,y){[(x[0]+y[0])%p,(x[1]+y[1])%p]};mul=->(x,y){[(x[0]*y[0]+2*x[1]*y[1])%p,(x[0]*y[1]+x[1]*y[0])%p]};pw=->(x,n){r=[1,0];n.times{r=mul.call(r,x)};r}
ad=bad=0
e.each{|b|e.each{|c|next if pw.call(b,5)==c;e.each{|d|ad+=1;out=e.map{|x|add.call(add.call(add.call(pw.call(x,6),mul.call(b,pw.call(x,5))),mul.call(c,x)),d)};bad+=1 if out.uniq.length==25}}}
raise unless ad==15000&&bad==0
puts "#{ad} #{bad}"
