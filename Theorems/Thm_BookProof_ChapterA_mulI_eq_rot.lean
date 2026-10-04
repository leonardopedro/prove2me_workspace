-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.mulI_eq_rot
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.mulI_eq_rot (θ : AntiUnitary H) : (mulI : H →L[ℝ] H) = rot θ Complex.I 0 := by sorry
