#include <algorithm>
#include <cassert>
#include <iostream>
#include <map>
#include <string>
#include <vector>

static int mul(int a, int b) {
  if (a == 0) return b;
  if (b == 0) return a;
  if (a == 1) return b;
  if (b == 1) return a;
  if (a == b) return 1;
  return 2 + 3 + 4 - a - b;
}
static int hclass(int r) {
  int t = r % 4;
  return t == 1 ? 1 : t == 2 ? 2 : t == 3 ? 3 : 4;
}
static std::string key(const std::vector<int>& p) {
  std::string out;
  for (int x : p) { out += std::to_string(x); out.push_back(','); }
  return out;
}
static std::map<std::string, bool> memo;
static bool is_n(const std::vector<int>& p) {
  std::vector<int> pos;
  for (int x : p) if (x) pos.push_back(x);
  std::sort(pos.begin(), pos.end());
  std::string k = key(pos);
  auto it = memo.find(k);
  if (it != memo.end()) return it->second;
  if (pos.empty()) return memo[k] = true;
  for (int i = 0; i < (int)pos.size(); ++i) {
    for (int d = 1; d <= 3; ++d) {
      if (d >= pos[i]) continue;
      std::vector<int> nxt = pos;
      nxt[i] -= d;
      if (!is_n(nxt)) return memo[k] = true;
    }
  }
  return memo[k] = false;
}
static long long checked = 0;
static void enumerate(const std::vector<int>& prefix, int remaining, int min_value) {
  if (remaining == 0) {
    int image = 0;
    for (int x : prefix) image = mul(image, hclass(x));
    if (is_n(prefix) != (image != 1)) {
      std::cerr << "MISMATCH\n";
      std::exit(1);
    }
    ++checked;
    return;
  }
  for (int x = min_value; x <= 30; ++x) {
    std::vector<int> next = prefix;
    next.push_back(x);
    enumerate(next, remaining - 1, x);
  }
}
int main() {
  for (int a = 0; a < 5; ++a)
    for (int b = 0; b < 5; ++b)
      for (int c = 0; c < 5; ++c)
        assert(mul(mul(a,b),c) == mul(a,mul(b,c)));
  for (int count = 0; count <= 6; ++count) enumerate({}, count, 1);
  std::cout << "associativity=PASS; positions_checked=" << checked
            << "; classes=5; separation=PASS\nRESULT: PASS\n";
}
