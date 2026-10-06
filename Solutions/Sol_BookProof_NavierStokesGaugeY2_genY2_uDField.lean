-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY2_uDField
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_leibniz
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (i j k : Fin 3) : genY2 j (uDField i k) = 0 := by

  rw [uDField, map_add, genY2_X_uD, genY2_leibniz, genY2_X_uL, genY2_X_y]
  by_cases h : j = k <;> simp [h]
