import RingelN8Star

set_option maxRecDepth 1000000

namespace RingelN8StarMathlib

theorem mathlib_rechecks_cyclic_star_partition :
    RingelN8Star.allEdges.all (fun e => e ∈ RingelN8Star.usedEdges) = true ∧
    RingelN8Star.usedEdges.all (fun e => e ∈ RingelN8Star.allEdges) = true := by
  exact RingelN8Star.cyclic_star_partition

end RingelN8StarMathlib
