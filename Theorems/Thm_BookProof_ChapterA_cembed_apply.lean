-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.cembed_apply
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.cembed_apply (c : ℂ) (x : V) : (cembed c : V →L[ℝ] V) x = c • x := by sorry
