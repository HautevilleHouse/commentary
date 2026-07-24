def divisors(m); (1..m).select{|d| m%d==0}; end
cases={25=>[24,27],26=>[24,28],30=>[28,32]}
cases.each do |n,(w,bound)|
  bad=[]
  (0...n).each do |m|
    ds=m==0 ? [] : divisors(m)
    bad << [m,ds,ds.length,m+ds.length] if m+ds.length>bound
  end
  expected=[w,divisors(w),divisors(w).length,w+divisors(w).length]
  raise unless bad==[expected]
  puts "#{n} #{w} #{expected[2]} #{expected[3]} #{bound}"
end
