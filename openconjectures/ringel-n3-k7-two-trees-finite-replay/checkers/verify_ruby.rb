expected = (0...7).flat_map { |i| ((i + 1)...7).map { |j| [i, j] } }.sort
paths = (0...7).map { |i| [i, (i + 1) % 7, (i + 3) % 7, (i + 6) % 7] }
stars = (0...7).map { |i| [i, (i + 1) % 7, (i + 2) % 7, (i + 3) % 7] }
path_edges = paths.flat_map { |r| (0...3).map { |j| [r[j], r[j + 1]].sort } }
star_edges = stars.flat_map { |r| r[1..].map { |x| [r[0], x].sort } }
raise "paths" unless path_edges.uniq.length == 21 && path_edges.sort == expected
raise "stars" unless star_edges.uniq.length == 21 && star_edges.sort == expected
puts({trees: 2, edges_each: 21, status: "PASS"})
