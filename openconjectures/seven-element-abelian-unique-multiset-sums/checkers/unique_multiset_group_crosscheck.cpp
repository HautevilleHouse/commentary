// Independently implemented exact cross-check for Open Problem 4 in
// arXiv:2607.08366v2 at n = 7.
//
// Usage: unique_multiset_group_crosscheck modulus [modulus ...]
// Each modulus is a primary cyclic direct factor. For example, 2 2 3 5
// denotes Z_2 x Z_2 x Z_3 x Z_5. The product must be below 64.
//
// Unlike the primary search, this program recomputes the necessary two- and
// three-subset-sum conditions from each whole prefix and performs no target-
// uniqueness prefix pruning. Every surviving seven-set is checked against all
// C(13, 6) size-seven multiplicity vectors.

#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

namespace {

using Clock = std::chrono::steady_clock;

struct Crosscheck {
  std::vector<int> moduli;
  int order = 1;
  std::vector<int> addition;
  std::vector<std::array<int, 7>> size_seven_compositions;
  std::array<int, 7> elements{};
  std::uint64_t nodes = 0;
  std::uint64_t full_candidates = 0;
  bool found = false;
  Clock::time_point started = Clock::now();

  int add(int left, int right) const {
    return addition[static_cast<std::size_t>(left) * order + right];
  }

  int repeat(int total, int element, int count) const {
    while (count-- > 0) {
      total = add(total, element);
    }
    return total;
  }

  bool distinct_subset_sums(int size, int subset_size) const {
    std::array<bool, 64> seen{};
    if (subset_size == 2) {
      for (int left = 0; left < size; ++left) {
        for (int right = left + 1; right < size; ++right) {
          const int sum = add(elements[left], elements[right]);
          if (seen[sum]) {
            return false;
          }
          seen[sum] = true;
        }
      }
      return true;
    }
    for (int first = 0; first < size; ++first) {
      for (int second = first + 1; second < size; ++second) {
        for (int third = second + 1; third < size; ++third) {
          const int sum = add(elements[first], add(elements[second], elements[third]));
          if (seen[sum]) {
            return false;
          }
          seen[sum] = true;
        }
      }
    }
    return true;
  }

  bool exact_target_is_unique() const {
    int target = 0;
    for (int element : elements) {
      target = add(target, element);
    }
    for (const auto& multiplicities : size_seven_compositions) {
      if (std::all_of(multiplicities.begin(), multiplicities.end(),
                      [](int value) { return value == 1; })) {
        continue;
      }
      int sum = 0;
      for (int index = 0; index < 7; ++index) {
        sum = repeat(sum, elements[index], multiplicities[index]);
      }
      if (sum == target) {
        return false;
      }
    }
    return true;
  }

  void enumerate(int size, int next) {
    if (found) {
      return;
    }
    ++nodes;
    if (size == 7) {
      ++full_candidates;
      found = exact_target_is_unique();
      return;
    }
    const int last = order - (7 - size);
    for (int candidate = next; candidate <= last; ++candidate) {
      elements[size] = candidate;
      const int new_size = size + 1;
      if (!distinct_subset_sums(new_size, 2) ||
          !distinct_subset_sums(new_size, 3)) {
        continue;
      }
      enumerate(new_size, candidate + 1);
      if (found) {
        return;
      }
    }
  }

  std::vector<int> decode(int encoded) const {
    std::vector<int> point;
    point.reserve(moduli.size());
    for (int modulus : moduli) {
      point.push_back(encoded % modulus);
      encoded /= modulus;
    }
    return point;
  }
};

void compositions_rec(int index, int remaining, std::array<int, 7>& current,
                      std::vector<std::array<int, 7>>& output) {
  if (index == 6) {
    current[index] = remaining;
    output.push_back(current);
    return;
  }
  for (int value = 0; value <= remaining; ++value) {
    current[index] = value;
    compositions_rec(index + 1, remaining - value, current, output);
  }
}

}  // namespace

int main(int argc, char** argv) {
  if (argc < 2) {
    std::cerr << "usage: " << argv[0] << " modulus [modulus ...]\n";
    return 64;
  }

  Crosscheck check;
  for (int index = 1; index < argc; ++index) {
    const int modulus = std::stoi(argv[index]);
    if (modulus < 2) {
      std::cerr << "all moduli must be at least two\n";
      return 64;
    }
    check.moduli.push_back(modulus);
    check.order *= modulus;
  }
  if (check.order >= 64) {
    std::cerr << "this bounded search requires group order below 64\n";
    return 64;
  }

  std::vector<std::vector<int>> coordinates(check.order);
  for (int element = 0; element < check.order; ++element) {
    coordinates[element] = check.decode(element);
  }
  check.addition.assign(static_cast<std::size_t>(check.order) * check.order, 0);
  for (int left = 0; left < check.order; ++left) {
    for (int right = 0; right < check.order; ++right) {
      int multiplier = 1;
      int encoded = 0;
      for (std::size_t coordinate = 0; coordinate < check.moduli.size();
           ++coordinate) {
        encoded += multiplier *
                   ((coordinates[left][coordinate] +
                     coordinates[right][coordinate]) %
                    check.moduli[coordinate]);
        multiplier *= check.moduli[coordinate];
      }
      check.addition[static_cast<std::size_t>(left) * check.order + right] = encoded;
    }
  }

  std::array<int, 7> current{};
  compositions_rec(0, 7, current, check.size_seven_compositions);
  if (check.size_seven_compositions.size() != 1716) {
    std::cerr << "internal composition enumeration failure\n";
    return 70;
  }

  check.elements[0] = 0;
  check.started = Clock::now();
  check.enumerate(1, 1);

  std::cout << "{\"group_moduli\":[";
  for (std::size_t index = 0; index < check.moduli.size(); ++index) {
    if (index != 0) {
      std::cout << ',';
    }
    std::cout << check.moduli[index];
  }
  const double seconds =
      std::chrono::duration<double>(Clock::now() - check.started).count();
  std::cout << "],\"order\":" << check.order << ",\"status\":\""
            << (check.found ? "witness" : "exhausted")
            << "\",\"nodes\":" << check.nodes
            << ",\"full_candidates\":" << check.full_candidates
            << ",\"seconds\":" << seconds;
  if (check.found) {
    std::cout << ",\"elements\":[";
    for (int index = 0; index < 7; ++index) {
      if (index != 0) {
        std::cout << ',';
      }
      const auto point = check.decode(check.elements[index]);
      std::cout << '[';
      for (std::size_t coordinate = 0; coordinate < point.size(); ++coordinate) {
        if (coordinate != 0) {
          std::cout << ',';
        }
        std::cout << point[coordinate];
      }
      std::cout << ']';
    }
    std::cout << ']';
  }
  std::cout << "}\n";
  return check.found ? 10 : 0;
}
