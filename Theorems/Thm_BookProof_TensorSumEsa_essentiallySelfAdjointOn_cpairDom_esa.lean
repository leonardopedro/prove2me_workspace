-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairDom_esa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
open BookProof.EsaClosure
open BookProof.GraphCore
open BookProof.TensorCore
open BookProof.TensorSumEsa

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}
variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)
variable {Hs Ks : IPSpace} [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
  (CA : Submodule ℂ Hs.carrier) (CB : Submodule ℂ Ks.carrier)
variable {Hs Ks : IPSpace}
variable [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairDom_esa {DA : Submodule ℂ Hs.carrier}
    {DB : Submodule ℂ Ks.carrier} (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
    (hdenseA : Dense (DA : Set Hs.carrier)) (hdenseB : Dense (DB : Set Ks.carrier))
    (hsymA : SymmetricOn DA A) (hsymB : SymmetricOn DB B)
    (hesaA : EssentiallySelfAdjointOn DA A) (hesaB : EssentiallySelfAdjointOn DB B) :
    EssentiallySelfAdjointOn (cpairDom Hs Ks DA DB) (cpairOp Hs Ks DA DB A B) := by sorry
