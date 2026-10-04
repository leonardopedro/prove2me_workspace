-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.Qanti_anticommutes_mulI
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace Quaternion



theorem BookProof.ChapterA.Qanti_anticommutes_mulI (S : V →L[ℝ] V) (x : V) :
    Qanti S (Complex.I • x) = -(Complex.I • Qanti S x) := by sorry
