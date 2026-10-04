-- Generated from ChapterA2d.lean — theorem BookProof.ChapterA.conjCLM_unitScale
import Mathlib
import Definitions.Def_ChapterA2d
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.conjCLM_unitScale (α : V ≃ₗᵢ[ℂ] W) (l : ℂ) (hl : ‖l‖ = 1) (m : V →L[ℂ] V) :
    conjCLM (α.trans (unitScaleEquiv l hl)) m = conjCLM α m := by sorry
