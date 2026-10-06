-- Generated from ChapterSqueezedGaussStates.lean — solution of BookProof.SqueezedGaussStates.Usum_identity
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Theorems.Thm_BookProof_SqueezedGaussStates_Acoef_zero
import Theorems.Thm_BookProof_SqueezedGaussStates_Acoef_rec
open BookProof.SqueezedGaussStates




open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : ℝ) (M : ℕ) :
    (1 - 4 * v ^ 2) * Usum v M = Vsum v M - 4 * v ^ 2 * (2 * (M : ℝ) + 1) * Acoef v M := by

  induction M with
  | zero => simp [Usum, Vsum, Acoef_zero]
  | succ m ih =>
      have hrec := Acoef_rec v m
      simp only [Usum, Vsum, Finset.sum_range_succ] at ih ⊢
      push_cast
      push_cast at ih hrec
      nlinarith [ih, hrec]
