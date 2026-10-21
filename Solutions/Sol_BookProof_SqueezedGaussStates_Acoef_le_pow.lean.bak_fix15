-- Generated from ChapterSqueezedGaussStates.lean — solution of BookProof.SqueezedGaussStates.Acoef_le_pow
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Theorems.Thm_BookProof_SqueezedGaussStates_Acoef_zero
import Theorems.Thm_BookProof_SqueezedGaussStates_Acoef_nonneg
import Theorems.Thm_BookProof_SqueezedGaussStates_Acoef_rec
open BookProof.SqueezedGaussStates




open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : ℝ) (M : ℕ) : Acoef v M ≤ (4 * v ^ 2) ^ M := by

  induction M with
  | zero => simp [Acoef_zero]
  | succ m ih =>
      have hrec := Acoef_rec v m
      have hpos : (0 : ℝ) < 2 * (m : ℝ) + 2 := by positivity
      have hA := Acoef_nonneg v m
      have hv2 : (0 : ℝ) ≤ 4 * v ^ 2 := by positivity
      have hstep : Acoef v (m + 1) ≤ 4 * v ^ 2 * Acoef v m := by nlinarith
      calc Acoef v (m + 1) ≤ 4 * v ^ 2 * Acoef v m := hstep
        _ ≤ 4 * v ^ 2 * (4 * v ^ 2) ^ m := mul_le_mul_of_nonneg_left ih hv2
        _ = (4 * v ^ 2) ^ (m + 1) := by ring
