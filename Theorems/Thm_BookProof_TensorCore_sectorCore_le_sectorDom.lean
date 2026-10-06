-- Generated from ChapterTensorGraphCore.lean — theorem BookProof.TensorCore.sectorCore_le_sectorDom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
open BookProof.DirectSumEsa
open BookProof.TensorCore

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

theorem BookProof.TensorCore.sectorCore_le_sectorDom (n : ℕ) :
    sectorCore Hs D₂ D n ≤ sectorDom Hs D₂ n := by sorry
