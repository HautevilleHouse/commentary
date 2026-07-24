#include <algorithm>
#include <array>
#include <cassert>
#include <iostream>
#include <map>
#include <set>
#include <vector>

using Pattern = std::set<std::pair<int, int>>;

bool is_involution(const std::vector<int>& p) {
  for (int i = 0; i < static_cast<int>(p.size()); ++i)
    if (p[p[i] - 1] != i + 1) return false;
  return true;
}

int count_occurrences(const std::vector<int>& p, const Pattern& shaded) {
  int count = 0;
  const int n = static_cast<int>(p.size());
  for (int i = 0; i < n; ++i) {
    for (int j = i + 1; j < n; ++j) {
      const int a = p[i], b = p[j];
      if (a >= b) continue;
      bool valid = true;
      for (int k = 0; k < n; ++k) {
        if (k == i || k == j) continue;
        const int x = k < i ? 0 : (k < j ? 1 : 2);
        const int y = p[k] < a ? 0 : (p[k] < b ? 1 : 2);
        if (shaded.count({x, y}) != 0) {
          valid = false;
          break;
        }
      }
      if (valid) ++count;
    }
  }
  return count;
}

int main() {
  const std::array<Pattern, 4> patterns = {
      Pattern{{{1, 2}, {1, 1}, {2, 1}, {0, 0}}},
      Pattern{{{2, 2}, {0, 1}, {1, 1}, {1, 0}}},
      Pattern{{{0, 2}, {1, 1}, {2, 1}, {1, 0}}},
      Pattern{{{1, 2}, {0, 1}, {1, 1}, {2, 0}}},
  };
  std::vector<int> p{1, 2, 3};
  std::map<int, std::map<int, int>> histogram;
  int involution_count = 0;
  do {
    if (!is_involution(p)) continue;
    ++involution_count;
    for (int i = 0; i < 4; ++i)
      ++histogram[i][count_occurrences(p, patterns[i])];
  } while (std::next_permutation(p.begin(), p.end()));

  assert(involution_count == 4);
  assert((histogram[0] == std::map<int, int>{{0, 2}, {1, 1}, {2, 1}}));
  assert(histogram[1] == histogram[0]);
  assert((histogram[2] == std::map<int, int>{{0, 1}, {1, 2}, {2, 1}}));
  assert(histogram[3] == histogram[2]);
  assert(histogram[0] != histogram[2]);

  std::cout << "involutions_n3=" << involution_count << "\n";
  for (int i = 0; i < 4; ++i) {
    std::cout << "P" << i + 1 << "_histogram=";
    for (const auto& [k, v] : histogram[i]) std::cout << k << ":" << v << " ";
    std::cout << "\n";
  }
  std::cout << "counterexample=Class69 P1 versus P3 on involutions of size 3\n";
}
