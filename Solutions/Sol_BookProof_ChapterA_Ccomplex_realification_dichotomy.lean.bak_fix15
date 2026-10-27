-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.Ccomplex_realification_dichotomy
import Mathlib
import Definitions.Def_ChapterA2e
import Theorems.Thm_BookProof_ChapterA_transK_sq
import Theorems.Thm_BookProof_ChapterA_transK_beta
import Theorems.Thm_BookProof_ChapterA_transK_realCommutes
import Theorems.Thm_BookProof_ChapterA_Rcomplex_realCommutant_eq_complex
import Theorems.Thm_BookProof_ChapterA_cembed_apply
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial W]
    {M : System ℂ V} {N : System ℂ W}
    (hSchurN : IsSchurFull N) (hNo : NoAntilinearCommutant N)
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) :
    CLinear β ∨ CAntilinear β := by

  -- `K = β ∘ (i·) ∘ β⁻¹` lies in the real commutant, hence is `c·1` (Prop 18).
  have hKcomm : RealCommutes N (transK β) := transK_realCommutes hβ
  obtain ⟨c, hc⟩ := (Rcomplex_realCommutant_eq_complex N hSchurN hNo (transK β)).1 hKcomm
  -- `K² = -1` forces `c² = -1`.
  have hKsq : (transK β) * (transK β) = -1 := transK_sq β
  have hcsq : c ^ 2 = -1 := by
    obtain ⟨w, hw⟩ := exists_ne (0 : W)
    have h1 : (transK β) ((transK β) w) = -w := by
      have := congr_arg (fun T : W →L[ℝ] W => T w) hKsq
      simpa [ContinuousLinearMap.mul_apply] using this
    rw [hc] at h1
    simp only [cembed_apply] at h1
    rw [smul_smul] at h1
    have : (c * c) • w = (-1 : ℂ) • w := by rw [h1]; simp
    have hcc : c * c = -1 := by
      have := smul_left_injective ℂ hw this
      simpa using this
    rw [sq]; exact hcc
  -- `c = i` or `c = -i`.
  have hcval : c = Complex.I ∨ c = -Complex.I := by
    have hfac : (c - Complex.I) * (c + Complex.I) = 0 := by
      have : (c - Complex.I) * (c + Complex.I) = c ^ 2 - Complex.I ^ 2 := by ring
      rw [this, hcsq, Complex.I_sq]; ring
    rcases mul_eq_zero.1 hfac with h | h
    · left; linear_combination h
    · right; linear_combination h
  -- Translate `K = c·1` into the statement about `β`.
  have hKb : ∀ x, β (Complex.I • x) = c • β x := by
    intro x
    have := hc
    have h2 : transK β (β x) = c • (β x) := by rw [hc]; simp [cembed_apply]
    rw [transK_beta] at h2
    exact h2
  rcases hcval with h | h
  · left; intro x; rw [hKb x, h]
  · right; intro x; rw [hKb x, h]; simp
