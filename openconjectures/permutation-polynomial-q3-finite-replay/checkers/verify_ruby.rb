e=(0..2).flat_map{|a|(0..2).map{|b|[a,b]}}
add=->(x,y){[(x[0]+y[0])%3,(x[1]+y[1])%3]}
mul=->(x,y){[(x[0]*y[0]+2*x[1]*y[1])%3,(x[0]*y[1]+x[1]*y[0])%3]}
power=->(x,n){r=[1,0]; n.times{r=mul.call(r,x)};r}
admissible=0; permutations=0
e.each do |b|
  e.each do |c|
    next if power.call(b,3)==c
    e.each do |d|
      admissible+=1
      vals=e.map{|x| add.call(add.call(add.call(power.call(x,4),mul.call(b,power.call(x,3))),mul.call(c,x)),d)}
      permutations+=1 if vals.uniq.length==9
    end
  end
end
raise unless [admissible,permutations]==[648,0]
puts "#{admissible} #{permutations}"
