-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.essentiallySelfAdjointOn_of_graphCore
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterFarisLavineCore
open BookProof.GraphCore



open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


theorem BookProof.GraphCore.essentiallySelfAdjointOn_of_graphCore {D₁ D₂ : Submodule ℂ F} (T : D₂ →ₗ[ℂ] F)
    (h : D₁ ≤ D₂) (hcore : IsGraphCore D₁ T)
    (hesa : EssentiallySelfAdjointOn D₂ T) :
    EssentiallySelfAdjointOn D₁ (restrictOp T h) := by sorry
