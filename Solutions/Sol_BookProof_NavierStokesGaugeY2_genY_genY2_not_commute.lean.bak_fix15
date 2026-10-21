-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY_genY2_not_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY_genY2_bracket_X_u
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : ⁅genY j, genY2 j⁆ ≠ 0 := by

  intro h
  have h0 : ⁅genY j, genY2 j⁆ (X (NSVar.u 0)) = 0 := by rw [h]; simp
  rw [genY_genY2_bracket_X_u 0 j, neg_eq_zero] at h0
  exact X_ne_zero (R := ℂ) (NSVar.uL 0) h0
