PAIRS = {
  'class54' => [ [[0,0],[0,1],[1,1],[2,0],[2,2]], [[0,1],[0,2],[1,1],[2,0],[2,2]] ],
  'class69' => [ [[0,1],[1,1],[1,2],[2,0]], [[0,1],[1,0],[1,1],[2,2]] ],
  'class71' => [ [[0,0],[0,1],[1,2],[2,0]], [[0,0],[0,1],[1,0],[2,2]] ]
}
def count(p, shaded)
  n = p.length; total = 0
  (0...n).each do |i|
    ((i+1)...n).each do |j|
      next unless p[i] < p[j]
      lo, hi = p[i], p[j]; ok = true
      p.each_with_index do |v,pos|
        next if pos == i || pos == j
        c = pos < i ? 0 : (pos < j ? 1 : 2)
        r = v < lo ? 0 : (v < hi ? 1 : 2)
        if shaded.include?([r,c]); ok = false; break end
      end
      total += 1 if ok
    end
  end
  total
end
def each_perm(a, k=0, &blk)
  if k == a.length then yield a; return end
  (k...a.length).each do |i|
    a[k],a[i] = a[i],a[k]; each_perm(a,k+1,&blk); a[k],a[i] = a[i],a[k]
  end
end
PAIRS.each do |name, pair|
  (1..9).each do |n|
    h = [Hash.new(0), Hash.new(0)]; a=(1..n).to_a
    each_perm(a) { |p| h[0][count(p,pair[0])] += 1; h[1][count(p,pair[1])] += 1 }
    raise "mismatch #{name} n=#{n}" unless h[0] == h[1]
  end
  puts "#{name}: equal through n=9"
end
