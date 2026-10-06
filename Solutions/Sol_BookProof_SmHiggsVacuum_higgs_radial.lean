-- Generated from ChapterSmHiggsVacuum.lean — solution of BookProof.SmHiggsVacuum.higgs_radial
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum




open Finset

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {lam mu2 : ℝ} {u : E} (hu : lam * ‖u‖ ^ 2 = mu2) (t : ℝ) :
    higgsV lam mu2 ((1 + t) • u)
      = higgsV lam mu2 u + mu2 * ‖u‖ ^ 2 * t ^ 2 * (1 + t + t ^ 2 / 4) := by

  have hnorm : ‖(1 + t) • u‖ ^ 2 = (1 + t) ^ 2 * ‖u‖ ^ 2 := by
    rw [norm_smul]
    simp only [Real.norm_eq_abs, mul_pow, sq_abs]
  have hfour : ‖(1 + t) • u‖ ^ 4 = ((1 + t) ^ 2 * ‖u‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul, hnorm]
  have hfour' : ‖u‖ ^ 4 = (‖u‖ ^ 2) ^ 2 := by
    rw [show (4 : ℕ) = 2 * 2 from rfl, pow_mul]
  subst hu
  simp only [higgsV, hnorm, hfour, hfour']
  ring
