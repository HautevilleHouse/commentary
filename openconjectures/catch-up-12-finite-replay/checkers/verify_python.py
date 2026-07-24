from functools import lru_cache


@lru_cache(None)
def value(remaining, me, opp, first):
    remaining = set(remaining)
    if not remaining:
        return "win" if me > opp else "loss" if opp > me else "draw"
    if me + sum(remaining) < opp:
        return "loss"
    outcomes = []
    for x in sorted(remaining):
        rest = tuple(sorted(remaining - {x}))
        me2 = me + x
        if first or me2 >= opp:
            child = value(rest, opp, me2, False)
            outcomes.append({"win": "loss", "loss": "win", "draw": "draw"}[child])
        else:
            outcomes.append(value(rest, me2, opp, False))
    rank = {"loss": 0, "draw": 1, "win": 2}
    return max(outcomes, key=rank.get)


assert value((1, 2), 0, 0, True) == "win"
print("win")
