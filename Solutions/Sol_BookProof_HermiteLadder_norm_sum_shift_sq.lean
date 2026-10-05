-- Generated from ChapterHermiteLadderShift.lean — solution of BookProof.HermiteLadder.norm_sum_shift_sq
import Mathlib
import Definitions.Def_ChapterHermiteLadderShift
open BookProof.HermiteLadder




open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QgHermiteOscillator
open BookProof.HyperbolicQuadratic

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (v : ι → E) (hv : Orthonormal ℂ v) (σ : ι → ι) (S : Finset ι)
    (hinj : ∀ a ∈ S, ∀ b ∈ S, σ a = σ b → a = b) (g : ι → ℂ) :
    ‖∑ a ∈ S, g a • v (σ a)‖ ^ 2 = ∑ a ∈ S, ‖g a‖ ^ 2 := by

  classical
  have hio : ∀ i j : ι, (inner ℂ (v i) (v j) : ℂ) = if i = j then 1 else 0 := by
    intro i j
    by_cases h : i = j
    · subst h
      rw [inner_self_eq_norm_sq_to_K, hv.1 i, if_pos rfl]
      norm_num
    · rw [hv.inner_eq_zero h, if_neg h]
  have hinner : (inner ℂ (∑ a ∈ S, g a • v (σ a)) (∑ a ∈ S, g a • v (σ a)) : ℂ)
      = ∑ a ∈ S, ((‖g a‖ ^ 2 : ℝ) : ℂ) := by
    rw [sum_inner]
    refine Finset.sum_congr rfl fun a ha => ?_
    rw [inner_smul_left, inner_sum]
    have hterm : ∀ b ∈ S, (inner ℂ (v (σ a)) (g b • v (σ b)) : ℂ)
        = if b = a then g a else 0 := by
      intro b hb
      rw [inner_smul_right, hio]
      by_cases hab : b = a
      · subst hab; simp
      · have hne : ¬ (σ a = σ b) := fun h => hab (hinj b hb a ha h.symm)
        simp [hne, hab]
    rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq' S a]
    rw [if_pos ha]
    rw [← Complex.normSq_eq_conj_mul_self]
    simp [Complex.normSq_eq_norm_sq]
  have hre := congrArg Complex.re hinner
  rw [inner_self_eq_norm_sq_to_K] at hre
  simpa [← Complex.ofReal_pow, Complex.re_sum] using hre
