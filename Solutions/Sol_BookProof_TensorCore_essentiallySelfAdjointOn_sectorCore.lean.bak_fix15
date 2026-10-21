-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.essentiallySelfAdjointOn_sectorCore
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Theorems.Thm_BookProof_TensorCore_sectorCore_le_sectorDom
import Theorems.Thm_BookProof_TensorCore_isGraphCore_sectorCore
import Theorems.Thm_BookProof_GraphCore_essentiallySelfAdjointOn_of_graphCore
open BookProof.TensorCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hcore : IsGraphCore D A) (n : ℕ)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ n) (sectorOp Hs D₂ A n)) :
    EssentiallySelfAdjointOn (sectorCore Hs D₂ D n)
      (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n)) := essentiallySelfAdjointOn_of_graphCore _ _ (isGraphCore_sectorCore Hs D₂ A D hcore n) hesa
