#include <algorithm>
#include <array>
#include <iostream>
#include <map>
#include <vector>
using Box=std::pair<int,int>;
using Hist=std::map<int,long long>;
int occ(const std::array<int,10>& p,const std::vector<Box>& sh){
  int n=10,total=0;
  for(int i=0;i<n;i++) for(int j=i+1;j<n;j++) if(p[i]<p[j]){
    int lo=p[i],hi=p[j]; bool ok=true;
    for(int z=0;z<n;z++) if(z!=i&&z!=j){
      int c=z<i?0:(z<j?1:2),r=p[z]<lo?0:(p[z]<hi?1:2);
      if(std::find(sh.begin(),sh.end(),Box{r,c})!=sh.end()){ok=false;break;}
    }
    if(ok) total++;
  }
  return total;
}
int main(){
  std::vector<std::pair<std::vector<Box>,std::vector<Box>>> ps={
    {{{0,0},{0,1},{1,1},{2,0},{2,2}},{{0,1},{0,2},{1,1},{2,0},{2,2}}},
    {{{0,1},{1,1},{1,2},{2,0}},{{0,1},{1,0},{1,1},{2,2}}},
    {{{0,0},{0,1},{1,2},{2,0}},{{0,0},{0,1},{1,0},{2,2}}}
  };
  for(size_t q=0;q<ps.size();q++){
    Hist a,b; std::array<int,10> p{}; for(int i=0;i<10;i++)p[i]=i+1;
    do{a[occ(p,ps[q].first)]++;b[occ(p,ps[q].second)]++;}while(std::next_permutation(p.begin(),p.end()));
    if(a!=b){std::cerr<<"mismatch pair "<<q<<"\n";return 1;}
    std::cout<<"pair "<<q<<" equal through n=10\n";
  }
}
