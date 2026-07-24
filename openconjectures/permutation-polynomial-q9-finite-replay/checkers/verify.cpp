#include <array>
#include <cstdint>
#include <iostream>

// F_81 = F_3[t]/(t^4+t+2). Elements are base-3 coefficient vectors.
using E = std::array<int,4>;
E add(E a, E b) { for (int i=0;i<4;i++) a[i]=(a[i]+b[i])%3; return a; }
E mul(E a, E b) {
  int z[7]{};
  for (int i=0;i<4;i++) for (int j=0;j<4;j++) z[i+j]=(z[i+j]+a[i]*b[j])%3;
  // t^4 = 1 + 2t modulo t^4+t+2.
  for (int d=6; d>=4; --d) { int c=z[d]%3; z[d]=0; z[d-3]=(z[d-3]+c)%3; z[d-2]=(z[d-2]+2*c)%3; }
  return E{z[0],z[1],z[2],z[3]};
}
E pw(E a, int n) { E r{1,0,0,0}; while(n){ if(n&1) r=mul(r,a); a=mul(a,a); n>>=1; } return r; }
int code(E a) { return a[0]+3*a[1]+9*a[2]+27*a[3]; }
E elem(int n) { return E{n%3,(n/3)%3,(n/9)%3,(n/27)%3}; }

int main() {
  const int q=9, N=81; long long admissible=0, witnesses=0;
  for (int bi=0;bi<N;bi++) for (int ci=0;ci<N;ci++) for (int di=0;di<N;di++) {
    E b=elem(bi), c=elem(ci), d=elem(di);
    if (code(pw(b,9))==code(c)) continue;
    ++admissible; bool seen[N]{}; bool perm=true;
    for (int xi=0;xi<N;xi++) {
      E x=elem(xi), x9=pw(x,9), v=add(add(add(pw(x,10),mul(b,x9)),mul(c,x)),d);
      int k=code(v); if (seen[k]) {perm=false; break;} seen[k]=true;
    }
    if (perm) ++witnesses;
  }
  std::cout << "q=9 field_size=81 admissible_triples=" << admissible << " permutation_witnesses=" << witnesses << "\n";
}
