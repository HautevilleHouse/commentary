#!/usr/bin/env ruby
# Self-contained finite replay of the q-Catalan insertion obligations.
N = 8

def avoids(p)
  (0...p.length).each do |i|
    ((i + 1)...p.length).each do |j|
      ((j + 1)...p.length).each { |k| return false if p[i] > p[k] && p[k] > p[j] }
    end
  end
  true
end

def inv(p)
  p.each_index.sum { |i| ((i + 1)...p.length).count { |j| p[i] > p[j] } }
end

prev = [[]]
(1..N).each do |n|
  (0...n).each do |k|
    domain = prev.select { |p| n == 1 || p.index(n - 1) <= k }
    image = domain.map { |p| p[0...k] + [n] + p[k..] }
    image.each do |z|
      raise 'avoidance' unless avoids(z) && z.index(n) == k
      p = z[0...k] + z[(k + 1)..]
      raise 'inv increment' unless inv(z) - inv(p) == n - k - 1
      raise 'coinv increment' unless ((n * (n - 1) / 2 - inv(z)) -
        ((n - 1) * (n - 2) / 2 - inv(p))) == k
    end
    target = (1..n).to_a.permutation.select { |p| avoids(p) && p.index(n) == k }
    raise 'image mismatch' unless image.sort == target.sort
  end
  prev = (1..n).to_a.permutation.select { |p| avoids(p) }
  raise 'saturated row' unless prev.all? { |p| p.index(n) <= n - 1 }
end
puts({max_n: N, status: 'PASS'})
