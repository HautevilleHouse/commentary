#include <iostream>
#include <algorithm>
#include <cstdint>
#include <vector>

struct Big {
  static constexpr uint32_t BASE = 1000000000U;
  std::vector<uint32_t> d;
  Big(uint64_t x = 0) { while (x) { d.push_back(x % BASE); x /= BASE; } }
  Big& operator+=(const Big& other) {
    uint64_t carry = 0;
    const size_t n = std::max(d.size(), other.d.size());
    d.resize(n, 0);
    for (size_t i = 0; i < n; ++i) {
      uint64_t s = uint64_t(d[i]) + (i < other.d.size() ? other.d[i] : 0) + carry;
      d[i] = uint32_t(s % BASE); carry = s / BASE;
    }
    if (carry) d.push_back(uint32_t(carry));
    return *this;
  }
};
static bool operator<(const Big& a, const Big& b) {
  if (a.d.size() != b.d.size()) return a.d.size() < b.d.size();
  for (size_t i = a.d.size(); i-- > 0;) if (a.d[i] != b.d[i]) return a.d[i] < b.d[i];
  return false;
}
using Poly = std::vector<Big>;

static std::vector<std::vector<Poly>> build_qbinom(int max_n) {
  std::vector<std::vector<Poly>> g(max_n + 1);
  for (int n = 0; n <= max_n; ++n) g[n].resize(n + 1);
  g[0][0] = Poly{Big(1)};
  for (int n = 1; n <= max_n; ++n) {
    g[n][0] = Poly{Big(1)};
    g[n][n] = Poly{Big(1)};
    for (int k = 1; k < n; ++k) {
      const Poly& left = g[n-1][k];
      const Poly& right = g[n-1][k-1];
      Poly out(std::max(left.size(), right.size() + n - k));
      for (size_t i = 0; i < left.size(); ++i) out[i] += left[i];
      for (size_t i = 0; i < right.size(); ++i) out[i + n - k] += right[i];
      g[n][k] = std::move(out);
    }
  }
  return g;
}

int main() {
  const auto g = build_qbinom(120);
  long long quadruples = 0, coefficients = 0;
  for (int a = 1; a <= 60; ++a) for (int b = a + 1; b <= 60; ++b)
    for (int c = b + 1; c <= 60; ++c) {
      if ((b * c) % a) continue;
      const int d = (b * c) / a;
      if (!(c < d && d <= 60)) continue;
      ++quadruples;
      const Poly& lhs = g[b+c][b];
      const Poly& rhs = g[a+d][a];
      const size_t degree = std::max(lhs.size(), rhs.size());
      for (size_t i = 0; i < degree; ++i) {
        const Big lv = i < lhs.size() ? lhs[i] : Big(0);
        const Big rv = i < rhs.size() ? rhs[i] : Big(0);
        ++coefficients;
        if (lv < rv) {
          std::cerr << "NEGATIVE coefficient at " << a << ',' << b << ',' << c
                    << ',' << d << " degree " << i << '\n';
          return 1;
        }
      }
    }
  std::cout << "quadruples=" << quadruples << "; coefficients_checked="
            << coefficients << "; negative_coefficients=0\nRESULT: PASS\n";
  return 0;
}
