-- Generated from ChapterEsaOneParticleDGamma.lean — theorem BookProof.EsaOneParticle.not_isSelfAdjointOn_restrict
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterUnitaryTransport
open BookProof.GraphCore
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.TensorCore
open BookProof.ChapterUnboundedPosition
open BookProof.ChapterUnitaryTransport
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

theorem BookProof.EsaOneParticle.not_isSelfAdjointOn_restrict (T : UnboundedSelfAdjoint Hs.carrier)
    {D : Submodule ℂ Hs.carrier} (hle : D ≤ T.domain) (hne : D ≠ T.domain) :
    ¬ IsSelfAdjointOn D (restrictOp T.op hle) := by sorry
