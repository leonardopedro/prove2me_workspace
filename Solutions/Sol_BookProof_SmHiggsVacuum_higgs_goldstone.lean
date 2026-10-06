-- Generated from ChapterSmHiggsVacuum.lean — solution of BookProof.SmHiggsVacuum.higgs_goldstone
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum




open Finset

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {lam mu2 : ℝ} {u w : E} (hu : lam * ‖u‖ ^ 2 = mu2)
    (hperp : (inner ℝ u w : ℝ) = 0) (t : ℝ) :
    higgsV lam mu2 (u + t • w) = higgsV lam mu2 u + (lam / 4) * t ^ 4 * ‖w‖ ^ 4 := by

  have hnorm : ‖u + t • w‖ ^ 2 = ‖u‖ ^ 2 + t ^ 2 * ‖w‖ ^ 2 := by
    rw [norm_add_sq_real, inner_smul_right, hperp, norm_smul]
    simp only [Real.norm_eq_abs, mul_pow, sq_abs]
    ring
  have hfour : ‖u + t • w‖ ^ 4 = (‖u‖ ^ 2 + t ^ 2 * ‖w‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul, hnorm]
  have hfour' : ‖u‖ ^ 4 = (‖u‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul]
  have hwfour : ‖w‖ ^ 4 = (‖w‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul]
  subst hu
  simp only [higgsV, hnorm, hfour, hfour', hwfour]
  ring
