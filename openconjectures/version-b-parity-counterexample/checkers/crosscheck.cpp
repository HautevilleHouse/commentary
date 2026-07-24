#include <algorithm>
#include <array>
#include <cstdint>
#include <iostream>
#include <stdexcept>
#include <unordered_map>
#include <vector>

namespace {
constexpr int MaxPiles = 12;
constexpr int MaxValue = 10;
using Counts = std::array<unsigned char, MaxValue + 1>;
struct State { Counts c{}; int piles=0; int tokens=0; std::uint64_t key=0; };

std::uint64_t encode(const Counts& c) {
  std::uint64_t key=0, place=1;
  for (int v=1; v<=MaxValue; ++v) { key += c[v]*place; place *= MaxPiles+1; }
  return key;
}
void generate(int v, int remaining, Counts& c, std::vector<State>& out) {
  if (v>MaxValue) {
    State s; s.c=c;
    for (int i=1;i<=MaxValue;++i) { s.piles+=c[i]; s.tokens+=i*c[i]; }
    s.key=encode(c); out.push_back(s); return;
  }
  for (int n=0;n<=remaining;++n) { c[v]=n; generate(v+1,remaining-n,c,out); }
  c[v]=0;
}
bool predicted(int k,int odd) {
  if (k%2) return odd%2==0;
  if (k%4==0) return (odd%2==0 && odd<=k/2-2) || (odd%2==1 && odd>=k/2+1 && odd<=k-1);
  return (odd%2==0 && odd<=k/2-1) || (odd%2==1 && odd>=k/2+2 && odd<=k-1);
}
int mex_value(const Counts& c,const std::unordered_map<std::uint64_t,unsigned char>& g) {
  std::array<bool,MaxValue+2> seen{};
  for (int v=1;v<=MaxValue;++v) if (c[v]) {
    Counts q=c; --q[v]; if (v>1) ++q[v-1]; seen.at(g.at(encode(q)))=true;
  }
  Counts q{}; bool nonempty=false;
  for (int v=1;v<=MaxValue;++v) if (c[v]) { nonempty=true; if(v>1) q[v-1]=c[v]; }
  if(nonempty) seen.at(g.at(encode(q)))=true;
  int mex=0; while(seen.at(mex)) ++mex; return mex;
}
}  // namespace

int main() {
  Counts scratch{}; std::vector<State> states; generate(1,MaxPiles,scratch,states);
  std::sort(states.begin(),states.end(),[](const State&a,const State&b){return a.tokens!=b.tokens?a.tokens<b.tokens:a.key<b.key;});
  std::unordered_map<std::uint64_t,unsigned char> g; g.reserve(states.size());
  for(const State&s:states) g.emplace(s.key,static_cast<unsigned char>(mex_value(s.c,g)));
  std::uint64_t tested=0; bool found=false; State first; int first_odd=0;
  for(const State&s:states) {
    if(s.piles<3) continue; int minimum=(s.piles+2)/3+1, odd=0; bool eligible=true;
    for(int v=1;v<=MaxValue;++v) { if(s.c[v]&&v<minimum) eligible=false; if(v%2) odd+=s.c[v]; }
    if(!eligible) continue; ++tested;
    if(!found && ((g.at(s.key)==0)!=predicted(s.piles,odd))) { found=true; first=s; first_odd=odd; }
  }
  Counts x{},y{}; x[5]=7;x[6]=5;y[4]=7;y[5]=5;
  std::cout<<"states="<<states.size()<<'\n'<<"eligible_positions_tested="<<tested<<'\n'
           <<"target_nimber="<<int(g.at(encode(x)))<<'\n'<<"all_option_nimber="<<int(g.at(encode(y)))<<'\n'
           <<"target_predicted_p="<<predicted(12,7)<<'\n'<<"first_mismatch_piles="<<first.piles<<'\n'
           <<"first_mismatch_odd="<<first_odd<<'\n'<<"first_mismatch_counts=";
  for(int v=1;v<=MaxValue;++v) if(first.c[v]) std::cout<<v<<':'<<int(first.c[v])<<',';
  std::cout<<'\n';
  if(!found||g.at(encode(x))==0||g.at(encode(y))!=0||!predicted(12,7)) throw std::runtime_error("cross-check failed");
}

