import RingelN7Star

set_option maxRecDepth 1000000

namespace RingelN7StarMathlib

theorem mathlib_rechecks_cyclic_star_partition :
    RingelN7Star.allEdges.all (fun e => e ∈ RingelN7Star.usedEdges) = true ∧
    RingelN7Star.usedEdges.all (fun e => e ∈ RingelN7Star.allEdges) = true := by
  exact RingelN7Star.cyclic_star_partition

end RingelN7StarMathlib
