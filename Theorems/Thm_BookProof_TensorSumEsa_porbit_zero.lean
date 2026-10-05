-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.porbit_zero
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TensorSumEsa

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}
variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.TensorSumEsa.porbit_zero (x : DA ⊗[ℂ] DB) :
    ((porbit P Q x 0 : cpairDom Hs Ks DA DB) : ctensor Hs Ks)
      = pairEmb Hs Ks (inclPair Hs Ks DA DB x) := by sorry
