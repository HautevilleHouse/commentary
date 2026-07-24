def value(remaining, me, opp, first, memo = {})
  key = [remaining.sort, me, opp, first]
  return memo[key] if memo.key?(key)
  if remaining.empty?
    return memo[key] = me > opp ? 'win' : (opp > me ? 'loss' : 'draw')
  end
  return memo[key] = 'loss' if me + remaining.sum < opp
  outcomes = remaining.map do |x|
    rest = remaining - [x]
    me2 = me + x
    if first || me2 >= opp
      child = value(rest, opp, me2, false, memo)
      { 'win' => 'loss', 'loss' => 'win', 'draw' => 'draw' }.fetch(child)
    else
      value(rest, me2, opp, false, memo)
    end
  end
  rank = { 'loss' => 0, 'draw' => 1, 'win' => 2 }
  memo[key] = outcomes.max_by { |outcome| rank.fetch(outcome) }
end

raise 'verification failed' unless value([1, 2], 0, 0, true) == 'win'
puts 'win'
