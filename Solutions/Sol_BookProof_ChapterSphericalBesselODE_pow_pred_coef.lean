-- Generated from ChapterSphericalBesselODE.lean — solution of BookProof.ChapterSphericalBesselODE.pow_pred_coef
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
open BookProof.ChapterSphericalBesselODE




open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    (l : ℝ) * r ^ (l - 1) = r ^ l * ((l : ℝ) / r) := by

  cases l with
  | zero => simp
  | succ m =>
      simp only [Nat.add_sub_cancel]
      rw [pow_succ]
      field_simp
