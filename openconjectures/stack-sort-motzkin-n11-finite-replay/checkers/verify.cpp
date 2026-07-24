#include <algorithm>
#include <vector>
#include <iostream>
using V=std::vector<int>;
V ss(const V& a){ if(a.empty()) return {}; int im=0; for(int i=1;i<(int)a.size();i++) if(a[i]>a[im]) im=i; V z=ss(V(a.begin(),a.begin()+im)),w=ss(V(a.begin()+im+1,a.end())); z.insert(z.end(),w.begin(),w.end()); z.push_back(a[im]); return z; }
int main(){ V p; for(int i=1;i<=11;i++) p.push_back(i); long long c=0; do { V q=p; q.push_back(0); auto b=ss(ss(q)); if(b==V{0,1,2,3,4,5,6,7,8,9,10,11}) c++; } while(std::next_permutation(p.begin(),p.end())); std::cout<<c<<"\n"; return c==5798?0:1; }
