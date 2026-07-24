def mex(values)
  n = 0
  n += 1 while values.include?(n)
  n
end

def options(p)
  p.each_index.map { |i| (p[0...i] + p[(i + 1)..] .to_a).sort.reverse }
end

def g(p, memo = {})
  return 0 if p.empty?
  memo[p] ||= mex(options(p).map { |q| g(q, memo) })
end

def h(p, memo = {})
  return 1 if p.empty?
  memo[p] ||= mex(options(p).map { |q| h(q, memo) })
end

raise unless options([3, 3]).all? { |q| q == [3] }
raise unless [g([], {}), h([], {})] == [0, 1]
raise unless [g([3], {}), h([3], {})] == [1, 0]
raise unless [g([3, 3], {}), h([3, 3], {})] == [0, 1]
puts "CRIM [3,3]: pair=(0,1); states=[3,3]->[3]->[]"
