-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genX_genX_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesGaugeY_pderiv_swap
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin 3) : ⁅genX j, genX k⁆ = 0 := by

  refine LinearMap.ext fun p => ?_
  simp only [Ring.lie_def, LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply,
    genX_apply, pderiv_swap (NSVar.x j) (NSVar.x k)]
  ring
