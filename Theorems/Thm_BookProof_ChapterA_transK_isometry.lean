-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.transK_isometry
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.transK_isometry (β : V ≃ₗᵢ[ℝ] W) (w : W) : ‖transK β w‖ = ‖w‖ := by sorry
