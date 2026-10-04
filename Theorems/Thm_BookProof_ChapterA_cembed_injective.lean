-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.cembed_injective
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace Quaternion



theorem BookProof.ChapterA.cembed_injective [Nontrivial V] :
    Function.Injective (cembed : ℂ → (V →L[ℝ] V)) := by sorry
