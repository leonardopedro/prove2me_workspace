-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.norm_expNeg_sub_add_smul_le
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : 0 ≤ A) {t : ℝ} (ht : 0 ≤ t)
    (h k : F) {M : ℝ} (hM : ∀ s ∈ Set.Icc (0 : ℝ) t, ‖expNeg A s k - k‖ ≤ M) :
    ‖expNeg A t h - h + t • k‖ ≤ t * (‖k - A h‖ + M) := by

  set g : ℝ → F := fun u => expNeg A u h - h + u • k with hg
  have hderiv : ∀ u ∈ Set.Icc (0 : ℝ) t,
      HasDerivWithinAt g (-(expNeg A u (A h)) + k) (Set.Icc (0 : ℝ) t) u := by
    intro u _
    have h1 : HasDerivAt (fun v : ℝ => expNeg A v h) (-(expNeg A u (A h))) u :=
      hasDerivAt_expNeg A u h
    have h2 : HasDerivAt (fun v : ℝ => v • k) k u := by
      simpa using (hasDerivAt_id u).smul_const k
    exact ((h1.sub_const h).add h2).hasDerivWithinAt
  have hbound : ∀ u ∈ Set.Icc (0 : ℝ) t, ‖-(expNeg A u (A h)) + k‖ ≤ ‖k - A h‖ + M := by
    intro u hu
    have hdec : -(expNeg A u (A h)) + k = expNeg A u (k - A h) + (k - expNeg A u k) := by
      rw [map_sub]; abel
    have h1 : ‖expNeg A u (k - A h)‖ ≤ ‖k - A h‖ := norm_expNeg_le A hA hu.1 _
    have h2 : ‖k - expNeg A u k‖ ≤ M := by
      rw [← norm_neg, neg_sub]
      exact hM u hu
    calc ‖-(expNeg A u (A h)) + k‖
        = ‖expNeg A u (k - A h) + (k - expNeg A u k)‖ := by rw [hdec]
      _ ≤ ‖expNeg A u (k - A h)‖ + ‖k - expNeg A u k‖ := norm_add_le _ _
      _ ≤ ‖k - A h‖ + M := by linarith
  have hmain := Convex.norm_image_sub_le_of_norm_hasDerivWithin_le (𝕜 := ℝ) hderiv hbound
    (convex_Icc (0 : ℝ) t) (Set.left_mem_Icc.2 ht) (Set.right_mem_Icc.2 ht)
  have hgt : g t = expNeg A t h - h + t • k := rfl
  have hg0 : g 0 = 0 := by simp [hg]
  rw [hgt, hg0, sub_zero] at hmain
  calc ‖expNeg A t h - h + t • k‖ ≤ (‖k - A h‖ + M) * ‖t - (0 : ℝ)‖ := hmain
    _ = t * (‖k - A h‖ + M) := by
        rw [sub_zero, Real.norm_eq_abs, abs_of_nonneg ht]; ring
