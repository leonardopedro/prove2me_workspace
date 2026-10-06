-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairCore
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_cpairCore_le_cpairDom
import Theorems.Thm_BookProof_TensorSumEsa_isGraphCore_cpairCore
import Theorems.Thm_BookProof_GraphCore_essentiallySelfAdjointOn_of_graphCore
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

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

set_option maxHeartbeats 1000000 in
theorem solution (hcoreA : IsGraphCore CA A)
    (hcoreB : IsGraphCore CB B)
    (hesa : EssentiallySelfAdjointOn (cpairDom Hs Ks DA DB) (cpairOp Hs Ks DA DB A B)) :
    EssentiallySelfAdjointOn (cpairCore Hs Ks DA DB CA CB)
      (restrictOp (cpairOp Hs Ks DA DB A B) (cpairCore_le_cpairDom Hs Ks DA DB CA CB)) :=
  essentiallySelfAdjointOn_of_graphCore _ _
      (isGraphCore_cpairCore Hs Ks DA DB A B CA CB hcoreA hcoreB) hesa
