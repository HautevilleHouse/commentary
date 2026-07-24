import Foundation
func ss(_ a:[Int])->[Int]{ if a.isEmpty{return []}; var m=0; for i in 1..<a.count { if a[i]>a[m]{m=i} }; return ss(Array(a[..<m])) + ss(Array(a[(m+1)...])) + [a[m]] }
func nextPerm(_ a: inout [Int])->Bool { if a.count<2{return false}; var i=a.count-2; while a[i]>=a[i+1] { if i==0{return false}; i-=1 }; var j=a.count-1; while a[j]<=a[i]{j-=1}; a.swapAt(i,j); var l=i+1,r=a.count-1; while l<r{a.swapAt(l,r);l+=1;r-=1}; return true }
var p=Array(1...11), count=0; repeat { if ss(ss(p+[0]))==Array(0...11){count+=1} } while nextPerm(&p); print(count); precondition(count==5798)
