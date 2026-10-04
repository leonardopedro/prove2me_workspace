-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.cembed_realCommutes
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace Quaternion



theorem BookProof.ChapterA.cembed_realCommutes (M : System ℂ V) (c : ℂ) :
    RealCommutes M (cembed c) := by sorry
