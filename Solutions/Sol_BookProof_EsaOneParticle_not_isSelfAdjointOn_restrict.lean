-- Generated from ChapterEsaOneParticleDGamma.lean — solution of BookProof.EsaOneParticle.not_isSelfAdjointOn_restrict
import Mathlib
import Definitions.Def_ChapterEsaOneParticleDGamma
import Theorems.Thm_BookProof_FriedrichsSquare_IsFriedrichsSqExtension_symmetric
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterUnitaryTransport
open BookProof.EsaOneParticle




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
open BookProof.GraphCore
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.TensorCore
open BookProof.ChapterUnboundedPosition
open BookProof.ChapterUnitaryTransport

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
theorem solution (T : UnboundedSelfAdjoint Hs.carrier)
    {D : Submodule ℂ Hs.carrier} (hle : D ≤ T.domain) (hne : D ≠ T.domain) :
    ¬ IsSelfAdjointOn D (restrictOp T.op hle) := by

  intro hsa
  refine hne (le_antisymm hle fun x hx => ?_)
  have hmem : x ∈ adjointDomain D (restrictOp T.op hle) :=
    ⟨T.op ⟨x, hx⟩, fun psi => T.symmetric ⟨(psi : Hs.carrier), hle psi.2⟩ ⟨x, hx⟩⟩
  rw [hsa] at hmem
  exact hmem
