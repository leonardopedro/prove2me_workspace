-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.Plin_commutes_mulI
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.Plin_commutes_mulI (S : V →L[ℝ] V) (x : V) :
    Plin S (Complex.I • x) = Complex.I • Plin S x := by sorry
