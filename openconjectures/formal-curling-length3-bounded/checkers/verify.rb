def k(s)
  best = 1
  (1..s.length).each do |l|
    block = s[-l, l]
    q = 0
    while (q + 1) * l <= s.length && s[-(q + 1) * l, l] == block
      q += 1
    end
    best = [best, q].max
  end
  best
end

def hit(s)
  t, steps = s.dup, 0
  while k(t) != 1
    t << k(t)
    steps += 1
  end
  steps
end

cases = (1..3).flat_map { |n| [-1, 0, 1].repeated_permutation(n).to_a }
hist = Hash.new(0)
cases.each { |s| hist[hit(s)] += 1 }
raise unless cases.length == 39 && hist == {0 => 27, 1 => 12}
puts 'PASS: 39 cases; histogram {0: 27, 1: 12}; maximum additional step 1'
