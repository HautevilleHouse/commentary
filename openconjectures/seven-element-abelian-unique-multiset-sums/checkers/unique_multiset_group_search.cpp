// Exact finite search for Open Problem 4 in arXiv:2607.08366v2 at n = 7.
//
// Usage: unique_multiset_group_search modulus [modulus ...]
// Each modulus is a primary cyclic direct factor.  For example, 2 2 3 5
// denotes Z_2 x Z_2 x Z_3 x Z_5.  The product must be below 64.
//
// Translation lets every candidate contain zero.  The search enumerates all
// remaining six elements in index order.  Every prefix is rejected as soon
// as its all-ones multiset has a competing same-size multiset; such a prefix
// can never extend to a valid seven-element family.  Distinct two- and
// three-subset sums provide additional necessary pruning.  A reported
// witness is verified again against every one of the C(13, 6) size-seven
// multiplicity vectors.

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

std::vector<int> moduli;
int order = 1;
std::vector<std::vector<int>> addition;
std::array<std::vector<std::vector<int>>, 8> compositions;
std::array<int, 7> chosen{};
std::uint64_t nodes = 0;
std::uint64_t full_candidates = 0;
bool found = false;
bool timed_out = false;
bool prefix_pruning = true;
double maximum_seconds = 0.0;
Clock::time_point started;

double elapsed_seconds() {
  return std::chrono::duration<double>(Clock::now() - started).count();
}

void make_compositions_rec(int slots, int remaining, std::vector<int>& current,
                           std::vector<std::vector<int>>& output) {
  if (slots == 1) {
    current.push_back(remaining);
    output.push_back(current);
    current.pop_back();
    return;
  }
  for (int value = 0; value <= remaining; ++value) {
    current.push_back(value);
    make_compositions_rec(slots - 1, remaining - value, current, output);
    current.pop_back();
  }
}

int add(int left, int right) { return addition[left][right]; }

int repeated_add(int total, int element, int multiplicity) {
  for (int count = 0; count < multiplicity; ++count) {
    total = add(total, element);
  }
  return total;
}

bool prefix_has_unique_multiset_sum(int size) {
  int target = 0;
  for (int index = 0; index < size; ++index) {
    target = add(target, chosen[index]);
  }
  for (const auto& multiplicities : compositions[size]) {
    bool all_ones = true;
    for (int value : multiplicities) {
      if (value != 1) {
        all_ones = false;
        break;
      }
    }
    if (all_ones) {
      continue;
    }
    int sum = 0;
    for (int index = 0; index < size; ++index) {
      sum = repeated_add(sum, chosen[index], multiplicities[index]);
    }
    if (sum == target) {
      return false;
    }
  }
  return true;
}

bool add_distinct_sum(std::uint64_t& mask, int value) {
  const std::uint64_t bit = std::uint64_t{1} << value;
  if ((mask & bit) != 0) {
    return false;
  }
  mask |= bit;
  return true;
}

void search(int size, int next, std::uint64_t pair_sums,
            std::uint64_t triple_sums) {
  if (found || timed_out) {
    return;
  }
  ++nodes;
  if (maximum_seconds > 0.0 && (nodes & 0xffffU) == 0U &&
      elapsed_seconds() >= maximum_seconds) {
    timed_out = true;
    return;
  }
  if (size == 7) {
    ++full_candidates;
    if (prefix_has_unique_multiset_sum(7)) {
      found = true;
    }
    return;
  }

  const int needed = 7 - size;
  const int final_start = order - needed;
  for (int candidate = next; candidate <= final_start; ++candidate) {
    std::uint64_t new_pair_sums = 0;
    bool admissible = true;
    for (int index = 0; index < size; ++index) {
      if (!add_distinct_sum(new_pair_sums,
                            add(candidate, chosen[index]))) {
        admissible = false;
        break;
      }
    }
    if (!admissible || (new_pair_sums & pair_sums) != 0) {
      continue;
    }

    std::uint64_t new_triple_sums = 0;
    for (int left = 0; left < size && admissible; ++left) {
      for (int right = left + 1; right < size; ++right) {
        const int value = add(candidate, add(chosen[left], chosen[right]));
        if (!add_distinct_sum(new_triple_sums, value)) {
          admissible = false;
          break;
        }
      }
    }
    if (!admissible || (new_triple_sums & triple_sums) != 0) {
      continue;
    }

    chosen[size] = candidate;
    if (prefix_pruning && !prefix_has_unique_multiset_sum(size + 1)) {
      continue;
    }
    search(size + 1, candidate + 1, pair_sums | new_pair_sums,
           triple_sums | new_triple_sums);
    if (found || timed_out) {
      return;
    }
  }
}

std::vector<int> decode(int value) {
  std::vector<int> coordinates;
  for (int modulus : moduli) {
    coordinates.push_back(value % modulus);
    value /= modulus;
  }
  return coordinates;
}

}  // namespace

int main(int argc, char** argv) {
  if (argc < 2) {
    std::cerr << "usage: " << argv[0] << " modulus [modulus ...]\n";
    return 64;
  }
  for (int index = 1; index < argc; ++index) {
    const int modulus = std::stoi(argv[index]);
    if (modulus < 2) {
      std::cerr << "all moduli must be at least two\n";
      return 64;
    }
    moduli.push_back(modulus);
    order *= modulus;
  }
  if (order >= 64) {
    std::cerr << "this bounded search requires group order below 64\n";
    return 64;
  }
  if (const char* limit = std::getenv("MAX_SECONDS")) {
    maximum_seconds = std::stod(limit);
  }
  if (const char* disabled = std::getenv("DISABLE_PREFIX_PRUNING")) {
    prefix_pruning = std::string(disabled) != "1";
  }

  std::vector<std::vector<int>> coordinates(order);
  for (int element = 0; element < order; ++element) {
    coordinates[element] = decode(element);
  }
  addition.assign(order, std::vector<int>(order, 0));
  for (int left = 0; left < order; ++left) {
    for (int right = 0; right < order; ++right) {
      int multiplier = 1;
      int encoded = 0;
      for (std::size_t coordinate = 0; coordinate < moduli.size();
           ++coordinate) {
        encoded += multiplier *
                   ((coordinates[left][coordinate] +
                     coordinates[right][coordinate]) %
                    moduli[coordinate]);
        multiplier *= moduli[coordinate];
      }
      addition[left][right] = encoded;
    }
  }
  for (int size = 1; size <= 7; ++size) {
    std::vector<int> current;
    make_compositions_rec(size, size, current, compositions[size]);
  }

  chosen[0] = 0;
  started = Clock::now();
  search(1, 1, 0, 0);

  std::cout << "{\"group_moduli\":[";
  for (std::size_t index = 0; index < moduli.size(); ++index) {
    if (index != 0) {
      std::cout << ',';
    }
    std::cout << moduli[index];
  }
  std::cout << "],\"order\":" << order << ",\"status\":\""
            << (found ? "witness" : (timed_out ? "unknown_timeout" : "exhausted"))
            << "\",\"prefix_pruning\":"
            << (prefix_pruning ? "true" : "false")
            << ",\"nodes\":" << nodes
            << ",\"full_candidates\":" << full_candidates
            << ",\"seconds\":" << elapsed_seconds();
  if (found) {
    std::cout << ",\"elements\":[";
    for (int index = 0; index < 7; ++index) {
      if (index != 0) {
        std::cout << ',';
      }
      const auto point = decode(chosen[index]);
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
  return found ? 10 : (timed_out ? 2 : 0);
}
