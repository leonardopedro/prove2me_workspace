-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.cembed_realCommutes
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.cembed_realCommutes (M : System ℂ V) (c : ℂ) :
    RealCommutes M (cembed c) := by sorry
