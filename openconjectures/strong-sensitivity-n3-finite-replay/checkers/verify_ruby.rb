pts=(0...8).to_a; blocks=(1...8).to_a; counts=Hash.new(0)
check=lambda do |t|
  s=bs=0
  pts.each do |x|
    singles=(0...3).count{|i| t[x^(1<<i)]!=t[x]}; s=[s,singles].max
    sens=blocks.select{|b| t[x^b]!=t[x]}; best=0
    (0...(1<<sens.length)).each do |mask|
      used=cnt=0; ok=true
      sens.each_with_index do |b,i|
        if (mask>>i)&1==1
          if (used&b)!=0 then ok=false; break end
          used|=b; cnt+=1
        end
      end
      best=[best,cnt].max if ok
    end
    bs=[bs,best].max
  end
  [bs,s]
end
(0...(1<<8)).each do |f|
  t=pts.map{|x|(f>>x)&1}; pair=check.call(t); raise unless pair[0] <= pair[1]**2; counts[pair]+=1
end
raise unless counts=={[0,0]=>2,[1,1]=>6,[2,2]=>110,[3,3]=>138}
puts '256 2 6 110 138'
