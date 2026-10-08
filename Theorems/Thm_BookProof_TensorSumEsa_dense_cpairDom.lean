-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.dense_cpairDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TensorSumEsa



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

theorem BookProof.TensorSumEsa.dense_cpairDom (hA : Dense (DA : Set Hs.carrier)) (hB : Dense (DB : Set Ks.carrier)) :
    Dense ((cpairDom Hs Ks DA DB : Submodule ℂ (ctensor Hs Ks)) : Set (ctensor Hs Ks)) := by sorry
