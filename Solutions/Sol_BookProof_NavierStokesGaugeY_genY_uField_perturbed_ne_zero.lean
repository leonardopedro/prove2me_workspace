-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genY_uField_perturbed_ne_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesGaugeY_genY_uField_perturbed
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) (c : ℂ) (hc : c ≠ 0) :
    genY j (uField i + C c * X (NSVar.y j)) ≠ 0 := by

  rw [genY_uField_perturbed]
  simpa using hc
