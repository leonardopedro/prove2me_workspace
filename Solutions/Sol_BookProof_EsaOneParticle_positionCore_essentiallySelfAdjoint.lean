-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.positionCore_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_dense_Dfin
import Theorems.Thm_BookProof_EsaOneParticle_positionCore_eig
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
theorem solution : EssentiallySelfAdjointOn Dfin positionCore := by

  refine essentiallySelfAdjointOn_of_dense_eigenvectors positionCore
    (fun k : ℤ => (⟨deltaVec k, Submodule.subset_span ⟨k, rfl⟩⟩ : Dfin))
    (fun k : ℤ => (k : ℝ)) (fun k => positionCore_eig k) ?_
  have hrange : (Set.range fun k : ℤ => ((⟨deltaVec k, Submodule.subset_span ⟨k, rfl⟩⟩ :
      Dfin) : L2Z)) = Set.range deltaVec := rfl
  rw [hrange]
  exact dense_Dfin
