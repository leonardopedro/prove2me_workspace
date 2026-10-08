-- Generated from ChapterTensorGraphCore.lean — theorem BookProof.TensorCore.symmetricOn_sectorOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.TensorCore



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

theorem BookProof.TensorCore.symmetricOn_sectorOp (hA : SymmetricOn D₂ A) (n : ℕ) :
    SymmetricOn (sectorDom Hs D₂ n) (sectorOp Hs D₂ A n) := by sorry
