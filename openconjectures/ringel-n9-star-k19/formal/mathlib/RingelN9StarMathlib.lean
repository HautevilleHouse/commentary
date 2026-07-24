import RingelN9Star

set_option maxRecDepth 1000000

namespace RingelN9StarMathlib

theorem mathlib_rechecks_cyclic_star_partition :
    RingelN9Star.allEdges.all (fun e => e ∈ RingelN9Star.usedEdges) = true ∧
    RingelN9Star.usedEdges.all (fun e => e ∈ RingelN9Star.allEdges) = true := by
  exact RingelN9Star.cyclic_star_partition

end RingelN9StarMathlib
