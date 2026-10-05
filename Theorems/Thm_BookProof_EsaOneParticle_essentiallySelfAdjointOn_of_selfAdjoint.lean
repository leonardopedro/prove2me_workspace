-- Generated from ChapterEsaOneParticleDGamma.lean — theorem BookProof.EsaOneParticle.essentiallySelfAdjointOn_of_selfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.EsaOneParticle

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



open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.EsaOneParticle.essentiallySelfAdjointOn_of_selfAdjoint (T : UnboundedSelfAdjoint Hs.carrier) :
    EssentiallySelfAdjointOn T.domain T.op := by sorry
