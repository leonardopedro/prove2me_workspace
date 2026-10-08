-- Generated from ChapterTensorGraphCore.lean — theorem BookProof.TensorCore.isGraphCore_sectorCore
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.DirectSumEsa
open BookProof.GraphCore
open BookProof.TensorCore



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

theorem BookProof.TensorCore.isGraphCore_sectorCore (hcore : IsGraphCore D A) (n : ℕ) :
    IsGraphCore (sectorCore Hs D₂ D n) (sectorOp Hs D₂ A n) := by sorry
