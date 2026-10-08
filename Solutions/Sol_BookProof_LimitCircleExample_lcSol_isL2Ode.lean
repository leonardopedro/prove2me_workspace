-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.lcSol_isL2Ode
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_hasDerivAt_lcSol
import Theorems.Thm_BookProof_LimitCircleExample_hasDerivAt_lcSol_prime
import Theorems.Thm_BookProof_LimitCircleExample_memLp_lcSol
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : IsL2Ode lcV Complex.I lcSol := ⟨fun x => lcLog' x * lcSol x, hasDerivAt_lcSol, hasDerivAt_lcSol_prime, memLp_lcSol⟩
