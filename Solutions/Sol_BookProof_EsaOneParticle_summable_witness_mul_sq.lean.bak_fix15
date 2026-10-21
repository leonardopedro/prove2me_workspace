-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.summable_witness_mul_sq
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
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
theorem solution :
    Summable (fun k : ℤ => ((k : ℝ) / ((k : ℝ) ^ 2 + 1)) ^ 2) := by

  refine summable_one_div_int_sq.of_nonneg_of_le (fun k => by positivity) (fun k => ?_)
  rcases eq_or_ne k 0 with rfl | hk
  · norm_num
  · have ht := one_le_int_sq hk
    rw [div_pow, div_le_div_iff₀ (by positivity) (by positivity)]
    nlinarith
