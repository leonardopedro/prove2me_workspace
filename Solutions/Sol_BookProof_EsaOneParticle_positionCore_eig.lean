-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.positionCore_eig
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
theorem solution (k : ℤ) :
    positionCore ⟨deltaVec k, Submodule.subset_span ⟨k, rfl⟩⟩
      = ((k : ℝ) : ℂ) • deltaVec k := by

  ext j
  by_cases hj : j = k
  · subst hj
    simp [positionCore, deltaVec, positionField, lp.single_apply]
  · simp [positionCore, deltaVec, positionField, lp.single_apply, hj]
