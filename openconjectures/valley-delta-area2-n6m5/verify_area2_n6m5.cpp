#include <algorithm>
#include <iostream>
#include <map>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

using Poly = std::map<std::pair<int,int>, std::map<int,int>>;
using Store = std::map<std::string, Poly>;

static std::string encode(const std::vector<int>& a, const std::vector<int>& w,
                          const std::vector<char>& selected,
                          const std::vector<int>& outside, int r, int ssz,
                          const std::vector<int>& blind,
                          const std::vector<std::pair<int,int>>& perdiag) {
  std::ostringstream out;
  out << r << '/' << ssz << '/';
  for (int j : outside) out << a[j] << ',' << w[j] << ',' << int(selected[j]) << ';';
  out << '/';
  for (int x : blind) out << x << ',';
  out << '/';
  for (auto p : perdiag) out << p.first << ',' << p.second << ';';
  return out.str();
}

static void add(Store& store, const std::string& key, int alpha, int beta, int dinv) {
  store[key][{alpha,beta}][dinv]++;
}

static int asymmetric(const Store& store) {
  int bad = 0;
  for (const auto& [key, poly] : store) {
    bool fail = false;
    for (const auto& [ab, qpoly] : poly) {
      auto sw = std::make_pair(ab.second, ab.first);
      auto it = poly.find(sw);
      const std::map<int,int> empty;
      const auto& other = (it == poly.end()) ? empty : it->second;
      if (qpoly != other) { fail = true; break; }
    }
    if (fail) ++bad;
  }
  return bad;
}

int main() {
  constexpr int n = 6, M = 5;
  Store blind, perdiag;

  for (int p = 1; p < n; ++p) for (int q = p + 1; q < n; ++q) {
    std::vector<int> a(n, 0); a[p] = a[q] = 1;
    int words = 1;
    for (int i = 0; i < n; ++i) words *= M;
    for (int code = 0; code < words; ++code) {
      int x = code;
      std::vector<int> w(n);
      for (int i = 0; i < n; ++i) { w[i] = x % M + 1; x /= M; }

      bool rises_ok = true;
      for (int i = 0; i + 1 < n; ++i)
        if (a[i+1] == a[i] + 1 && !(w[i] < w[i+1])) rises_ok = false;
      if (!rises_ok) continue;

      std::vector<int> valleys;
      for (int j = 1; j < n; ++j)
        if (a[j-1] > a[j] || (a[j-1] == a[j] && w[j-1] < w[j])) valleys.push_back(j);

      std::vector<std::pair<int,int>> attacks;
      for (int i = 0; i < n; ++i) for (int j = i + 1; j < n; ++j)
        if ((a[i] == a[j] && w[i] < w[j]) ||
            (a[i] == a[j] + 1 && w[i] > w[j])) attacks.push_back({i,j});

      const int subset_count = 1 << valleys.size();
      for (int mask = 0; mask < subset_count; ++mask) {
        std::vector<char> selected(n, 0);
        for (int z = 0; z < (int)valleys.size(); ++z)
          if (mask & (1 << z)) selected[valleys[z]] = 1;
        int ssz = __builtin_popcount((unsigned)mask);
        int dinv = -ssz;
        for (auto ij : attacks) if (!selected[ij.first]) ++dinv;

        for (int r = 1; r < M; ++r) {
          std::vector<int> outside;
          int alpha = 0, beta = 0;
          for (int j = 0; j < n; ++j) {
            if (w[j] != r && w[j] != r+1) outside.push_back(j);
            if (w[j] == r) ++alpha;
            if (w[j] == r+1) ++beta;
          }
          std::vector<int> blind_g(outside.size()+1, 0);
          std::vector<std::pair<int,int>> per_g(outside.size()+1, {0,0});
          int gap = 0;
          for (int j = 0; j < n; ++j) {
            if (w[j] != r && w[j] != r+1) { ++gap; continue; }
            if (!selected[j]) {
              ++blind_g[gap];
              if (a[j] == 0) ++per_g[gap].first;
              else if (a[j] == 1) ++per_g[gap].second;
            }
          }
          std::string prefix = encode(a,w,selected,outside,r,ssz,blind_g,{});
          std::string suffix = encode(a,w,selected,outside,r,ssz,{},per_g);
          add(blind, prefix, alpha, beta, dinv);
          add(perdiag, suffix, alpha, beta, dinv);
        }
      }
    }
  }

  int bad_blind = asymmetric(blind), bad_per = asymmetric(perdiag);
  std::cout << "n=6 M=5 [diag-blind]: refined classes=" << blind.size()
            << ", asymmetric=" << bad_blind << "\n";
  std::cout << "n=6 M=5 [per-diagonal]: refined classes=" << perdiag.size()
            << ", asymmetric=" << bad_per << "\n";
  std::cout << "RESULT: " << ((bad_blind == 0 && bad_per == 0) ? "PASS" : "FAIL") << "\n";
  return (bad_blind == 0 && bad_per == 0) ? 0 : 1;
}
