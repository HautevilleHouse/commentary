blocks = (1...16).to_a
dp = Array.new(1 << blocks.length, 0)
(1...(1 << blocks.length)).each do |cm|
  bit = cm & -cm; i = bit.bit_length - 1; rest = cm ^ bit
  blocked = 0
  blocks.each_with_index { |b,j| blocked |= (1 << j) if (blocks[i] & b) != 0 }
  a = dp[rest]
  b = 1 + dp[rest & ~blocked]
  dp[cm] = [a,b].max
end
dist = Hash.new(0)
(0...(1 << 16)).each do |code|
  ms = mb = 0
  (0...16).each do |x|
    changed = 0
    blocks.each_with_index do |b,i|
      changed |= (1 << i) if ((code >> x) & 1) != ((code >> (x ^ b)) & 1)
    end
    # In the block list 1..15, singleton blocks 1,2,4,8 have indices 0,1,3,7.
    s = [0,1,3,7].count { |k| ((changed >> k) & 1) == 1 }
    ms = s if s > ms
    mb = dp[changed] if dp[changed] > mb
  end
  raise "inequality failure #{code}" if mb > ms * ms
  dist[[ms,mb]] += 1
end
raise 'wrong function count' unless dist.values.sum == 65536
puts "functions=65536 inequality=PASS"
puts "distribution=#{dist.sort.inspect}"
