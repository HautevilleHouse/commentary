def mex(values)
  value = 0
  value += 1 while values.include?(value)
  value
end

def grundy(partition, misere)
  return misere ? 1 : 0 if partition.empty?
  options = partition.each_index.map do |index|
    remainder = partition.each_with_index.reject { |_, j| j == index }.map(&:first).sort.reverse
    grundy(remainder, misere)
  end
  mex(options.uniq)
end

(2..32).each do |m|
  raise unless grundy([m, 2], false) == 0
  raise unless grundy([m, 2], true) == 1
end

puts({ family: "[m,2]", m_range: [2, 32], conway_pair: [0, 1] })
