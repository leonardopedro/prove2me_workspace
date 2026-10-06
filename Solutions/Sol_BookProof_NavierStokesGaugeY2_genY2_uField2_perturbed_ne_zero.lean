-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY2_uField2_perturbed_ne_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_uField2_perturbed
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) (c : ℂ) (hc : c ≠ 0) :
    genY2 j (uField2 i + C c * (X (NSVar.y j) * X (NSVar.y j))) ≠ 0 := by

  rw [genY2_uField2_perturbed]
  refine mul_ne_zero ?_ (mul_ne_zero two_ne_zero (X_ne_zero _))
  simpa using hc
