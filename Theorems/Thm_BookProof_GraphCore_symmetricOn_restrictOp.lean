-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.symmetricOn_restrictOp
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterFarisLavineCore
open BookProof.GraphCore



open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


theorem BookProof.GraphCore.symmetricOn_restrictOp {D₁ D₂ : Submodule ℂ F} (T : D₂ →ₗ[ℂ] F) (h : D₁ ≤ D₂)
    (hT : SymmetricOn D₂ T) : SymmetricOn D₁ (restrictOp T h) := by sorry
