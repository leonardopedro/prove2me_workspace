-- Generated from ChapterSolidHarmonicTools.lean — solution of BookProof.ChapterSolidHarmonicTools.laplacian_normSqPow
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
open BookProof.ChapterSolidHarmonicTools




open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) (x : E) :
    (Δ fun y : E => (‖y‖ ^ 2) ^ m) x
      = (4 * m * ((m : ℝ) - 1) + 2 * (Module.finrank ℝ E) * m) * (‖x‖ ^ 2) ^ (m - 1) := by

  have hG : ContDiffAt ℝ 2 (fun q : ℝ => q ^ m) (‖x‖ ^ 2) := (contDiff_id.pow m).contDiffAt
  have h := laplacian_comp_normSq (G := fun q : ℝ => q ^ m) (x := x) hG
  rw [h]
  have hd : deriv (fun q : ℝ => q ^ m) = fun q : ℝ => (m : ℝ) * q ^ (m - 1) := by
    funext q; simp
  rw [hd]
  have hdd : deriv (fun q : ℝ => (m : ℝ) * q ^ (m - 1))
      = fun q : ℝ => (m : ℝ) * ((m - 1 : ℕ) : ℝ) * q ^ (m - 1 - 1) := by
    funext q
    rw [deriv_const_mul _ (by fun_prop)]
    simp [mul_assoc]
  rw [hdd]
  rcases m with _ | _ | m
  · simp
  · simp
  · simp only [Nat.add_sub_cancel]
    push_cast
    ring
