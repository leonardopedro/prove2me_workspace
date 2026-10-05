-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_EsaOneParticle_essentiallySelfAdjointOn_fockSectorDom_esa
import Theorems.Thm_BookProof_SecondQuantizationCore_dGamma_essentiallySelfAdjointOn_fockCore
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

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs D D n))
      (dGammaCoreOp Hs D A D) :=
  dGamma_essentiallySelfAdjointOn_fockCore Hs D A D (IsGraphCore.refl A)
      (essentiallySelfAdjointOn_fockSectorDom_esa A hdense hsym hesa)
