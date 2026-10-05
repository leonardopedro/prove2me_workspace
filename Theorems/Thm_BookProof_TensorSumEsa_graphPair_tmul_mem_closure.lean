-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.graphPair_tmul_mem_closure
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
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



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.TensorSumEsa.graphPair_tmul_mem_closure (hcoreA : IsGraphCore CA A) (hcoreB : IsGraphCore CB B)
    (a : DA) (b : DB) :
    graphPair Hs Ks DA DB A B (a ⊗ₜ[ℂ] b) ∈
      (Submodule.map (graphPair Hs Ks DA DB A B)
        (pairCorePoly Hs Ks DA DB CA CB)).topologicalClosure := by sorry
