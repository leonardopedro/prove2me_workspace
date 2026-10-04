-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.cembed_apply
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace Quaternion



theorem BookProof.ChapterA.cembed_apply (c : ℂ) (x : V) : (cembed c : V →L[ℝ] V) x = c • x := by sorry
