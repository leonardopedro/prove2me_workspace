-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.witness_mem_mulDomain
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_summable_witness_mul_sq
import Theorems.Thm_BookProof_EsaOneParticle_witness_apply
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)
variable {Hs : IPSpace} {D : Submodule ℂ Hs.carrier}
variable [CompleteSpace Hs.carrier]
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)
variable {Hs : IPSpace}

set_option maxHeartbeats 1000000 in
theorem solution : witness ∈ mulDomain positionField := by

  refine memℓp_gen ?_
  have h : (fun k : ℤ => ‖(positionField k : ℂ) * (witness : ℤ → ℂ) k‖ ^ (2 : ℝ≥0∞).toReal)
      = fun k : ℤ => ((k : ℝ) / ((k : ℝ) ^ 2 + 1)) ^ 2 := by
    funext k
    have hpos : (0 : ℝ) < (k : ℝ) ^ 2 + 1 := by positivity
    have habs : |(k : ℝ)| * (1 / ((k : ℝ) ^ 2 + 1)) = |(k : ℝ) / ((k : ℝ) ^ 2 + 1)| := by
      rw [abs_div, abs_of_pos hpos]; ring
    rw [show ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) by norm_num, Real.rpow_natCast, witness_apply,
      witnessFun, positionField, norm_mul, Complex.norm_real, Complex.norm_real,
      Real.norm_eq_abs, Real.norm_eq_abs,
      abs_of_nonneg (le_of_lt (by positivity : (0 : ℝ) < 1 / ((k : ℝ) ^ 2 + 1))), habs]
    norm_num [sq_abs]
  rw [h]
  exact summable_witness_mul_sq
