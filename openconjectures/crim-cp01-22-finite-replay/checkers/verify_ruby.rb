def mex(values)
  i = 0
  i += 1 while values.include?(i)
  i
end
opts = {[] => [], [2] => [[]], [2,2] => [[2]]}
g = {[] => 0}; h = {[] => 1}
[[2], [2,2]].each do |p|
  g[p] = mex(opts[p].map { |o| g[o] }.uniq)
  h[p] = mex(opts[p].map { |o| h[o] }.uniq)
end
raise "pair" unless [g[[2,2]], h[[2,2]]] == [0,1]
puts({state: [2,2], pair: [0,1], status: "PASS"})
