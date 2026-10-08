-- Generated from ChapterTensorGraphCore.lean — theorem BookProof.TensorCore.sectorOp_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

theorem BookProof.TensorCore.sectorOp_apply (n : ℕ) (x : sectorDom Hs D₂ n) (x₀ : ((domSpace Hs D₂).pow n))
    (hx : (x : Hs.pow n) = inclPow Hs D₂ n x₀) :
    sectorOp Hs D₂ A n x = derPow Hs D₂ A n x₀ := by sorry
