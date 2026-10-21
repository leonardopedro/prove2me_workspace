-- Generated from ChapterSpectralEnergyBound.lean — solution of BookProof.ChapterSpectralEnergyBound.norm_diagOp_le
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
open BookProof.ChapterSpectralEnergyBound




variable {n : Type*} [Fintype n]

variable {n : Type*} [Fintype n]

set_option maxHeartbeats 1000000 in
theorem solution (f : n → ℝ) (E : ℝ) (v : EuclideanSpace ℂ n)
    (h : ∀ i, v i ≠ 0 → |f i| ≤ E) :
    ‖diagOp f v‖ ≤ E * ‖v‖ := by

  classical
  by_cases hv : ∀ i, v i = 0
  · have hz : diagOp f v = 0 := by ext i; simp [hv i]
    have hz' : v = 0 := by ext i; simpa using hv i
    rw [hz, hz']
    simp
  push_neg at hv
  obtain ⟨i₀, hi₀⟩ := hv
  have hE : 0 ≤ E := le_trans (abs_nonneg _) (h i₀ hi₀)
  have hsq : ∀ i, ‖diagOp f v i‖ ^ 2 ≤ E ^ 2 * ‖v i‖ ^ 2 := by
    intro i
    by_cases hvi : v i = 0
    · simp [hvi]
    · have hfi : |f i| ≤ E := h i hvi
      have hnorm : ‖diagOp f v i‖ = |f i| * ‖v i‖ := by
        simp
      rw [hnorm, mul_pow]
      have h1 : |f i| ^ 2 ≤ E ^ 2 := by nlinarith [abs_nonneg (f i)]
      nlinarith [sq_nonneg ‖v i‖, norm_nonneg (v i)]
  have hsum : ∑ i, ‖diagOp f v i‖ ^ 2 ≤ E ^ 2 * ∑ i, ‖v i‖ ^ 2 := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun i _ => hsq i
  have hnorm : ‖diagOp f v‖ ^ 2 ≤ (E * ‖v‖) ^ 2 := by
    have h1 : ‖diagOp f v‖ ^ 2 = ∑ i, ‖diagOp f v i‖ ^ 2 := by
      rw [EuclideanSpace.norm_eq, Real.sq_sqrt]
      exact Finset.sum_nonneg fun i _ => by positivity
    have h2 : ‖v‖ ^ 2 = ∑ i, ‖v i‖ ^ 2 := by
      rw [EuclideanSpace.norm_eq, Real.sq_sqrt]
      exact Finset.sum_nonneg fun i _ => by positivity
    rw [h1, mul_pow, h2]
    exact hsum
  nlinarith [norm_nonneg (diagOp f v), norm_nonneg v, mul_nonneg hE (norm_nonneg v)]
