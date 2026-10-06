-- Generated from ChapterGraphCoreTransfer.lean — theorem BookProof.GraphCore.essentiallySelfAdjointOn_of_bounded_dense
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterFarisLavineCore
open BookProof.GraphCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine


theorem BookProof.GraphCore.essentiallySelfAdjointOn_of_bounded_dense {D : Submodule ℂ F} (T : D →ₗ[ℂ] F)
    (hT : SymmetricOn D T) {C : ℝ} (hC0 : 0 ≤ C) (hC : ∀ x : D, ‖T x‖ ≤ C * ‖(x : F)‖)
    (hdense : Dense (D : Set F)) :
    EssentiallySelfAdjointOn D T := by sorry
