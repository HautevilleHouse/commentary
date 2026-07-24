#include <algorithm>
#include <array>
#include <iostream>
#include <map>
#include <vector>
using Box=std::pair<int,int>; using Hist=std::map<int,long long>;
int occ(const std::array<int,11>& p,const std::vector<Box>& sh){int t=0;for(int i=0;i<11;i++)for(int j=i+1;j<11;j++)if(p[i]<p[j]){int lo=p[i],hi=p[j];bool ok=1;for(int z=0;z<11;z++)if(z!=i&&z!=j){int c=z<i?0:(z<j?1:2),r=p[z]<lo?0:(p[z]<hi?1:2);if(std::find(sh.begin(),sh.end(),Box{r,c})!=sh.end()){ok=0;break;}}if(ok)t++;}return t;}
int main(){std::vector<std::pair<std::vector<Box>,std::vector<Box>>> ps={{{{0,0},{0,1},{1,1},{2,0},{2,2}},{{0,1},{0,2},{1,1},{2,0},{2,2}}},{{{0,1},{1,1},{1,2},{2,0}},{{0,1},{1,0},{1,1},{2,2}}},{{{0,0},{0,1},{1,2},{2,0}},{{0,0},{0,1},{1,0},{2,2}}}};for(size_t q=0;q<ps.size();q++){Hist a,b;std::array<int,11> p{};for(int i=0;i<11;i++)p[i]=i+1;do{a[occ(p,ps[q].first)]++;b[occ(p,ps[q].second)]++;}while(std::next_permutation(p.begin(),p.end()));if(a!=b){std::cerr<<"mismatch pair "<<q<<"\n";return 1;}std::cout<<"pair "<<q<<" equal through n=11\n";}}
