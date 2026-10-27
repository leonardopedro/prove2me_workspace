-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genX_genY_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesGaugeY_pderiv_swap
import Theorems.Thm_BookProof_NavierStokesGaugeY_pderiv_x_mul_uD
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin 3) : ⁅genX j, genY k⁆ = 0 := by

  refine LinearMap.ext fun p => ?_
  simp only [Ring.lie_def, LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply,
    genX_apply, genY_apply, map_sub, map_sum, pderiv_x_mul_uD,
    pderiv_swap (NSVar.x j) (NSVar.u _), pderiv_swap (NSVar.x j) (NSVar.y k)]
  ring
