require 'set'
x=[0,1,2]; subs=(0...8).map{|mask|x.select{|i|(mask>>i)&1==1}.to_set}
def works(v,s,x,t)
 (t..3).all?{|n|(x.combination(n).all?{|c| target=c.to_set; v.values_at(*(s.each_index.select{|i|s[i].subset?(target)})).to_set==x.to_set})}
end
vals=[];(0...6561).each{|q|v=8.times.map{|i|(q/(3**i))%3};vals<<v}
counts=(0..2).map{|t|vals.count{|v|works(v,subs,x,t)}};raise unless counts==[0,0,720];puts 'H(3)=2; functions=6561; m0=0; m1=0; m2=720'
