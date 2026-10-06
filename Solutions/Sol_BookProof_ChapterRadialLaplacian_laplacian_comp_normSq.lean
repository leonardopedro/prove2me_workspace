-- Generated from ChapterRadialLaplacian.lean — solution of BookProof.ChapterRadialLaplacian.laplacian_comp_normSq
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
import Theorems.Thm_BookProof_ChapterRadialLaplacian_fderiv_fderiv_comp_normSq
open BookProof.ChapterRadialLaplacian




open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℝ E] {G : ℝ → ℝ} {x : E}
    (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    (Δ fun y : E => G (‖y‖ ^ 2)) x
      = 4 * ‖x‖ ^ 2 * deriv (deriv G) (‖x‖ ^ 2)
        + 2 * (Module.finrank ℝ E) * deriv G (‖x‖ ^ 2) := by

  have hsnd := fderiv_fderiv_comp_normSq hG
  rw [laplacian_eq_iteratedFDeriv_stdOrthonormalBasis]
  have hterm : ∀ i, iteratedFDeriv ℝ 2 (fun y : E => G (‖y‖ ^ 2)) x
      ![(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i]
      = 2 * deriv G (‖x‖ ^ 2) * ⟪(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i⟫_ℝ
        + 4 * deriv (deriv G) (‖x‖ ^ 2) * (⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ
            * ⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ) := by
    intro i
    rw [iteratedFDeriv_two_apply, hsnd]
    simp
    ring
  simp only [hterm]
  rw [Finset.sum_add_distrib]
  have h1 : ∑ i, 2 * deriv G (‖x‖ ^ 2)
      * ⟪(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i⟫_ℝ
      = 2 * (Module.finrank ℝ E) * deriv G (‖x‖ ^ 2) := by
    simp [(stdOrthonormalBasis ℝ E).orthonormal.1]
    ring
  have h2 : ∑ i, 4 * deriv (deriv G) (‖x‖ ^ 2) * (⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ
      * ⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ) = 4 * ‖x‖ ^ 2 * deriv (deriv G) (‖x‖ ^ 2) := by
    rw [← Finset.mul_sum]
    have hsum := (stdOrthonormalBasis ℝ E).sum_inner_mul_inner x x
    simp only [real_inner_comm x] at hsum ⊢
    rw [hsum, real_inner_self_eq_norm_sq]
    ring
  rw [h1, h2]
  ring
