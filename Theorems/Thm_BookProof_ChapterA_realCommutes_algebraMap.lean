-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.realCommutes_algebraMap
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.realCommutes_algebraMap (M : System ℂ V) (r : ℝ) :
    RealCommutes M (algebraMap ℝ (V →L[ℝ] V) r) := by sorry
