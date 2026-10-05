-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.positionCore_not_isSelfAdjointOn
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_not_isSelfAdjointOn_restrict
import Theorems.Thm_BookProof_EsaOneParticle_Dfin_ne_mulDomain
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
theorem solution : ¬ IsSelfAdjointOn Dfin positionCore := by

  have hne : Dfin ≠ (mulSA positionField).domain := Dfin_ne_mulDomain
  have hle : Dfin ≤ (mulSA positionField).domain := Dfin_le_mulDomain positionField
  exact not_isSelfAdjointOn_restrict (Hs := L2ZSpace) (mulSA positionField) hle hne
