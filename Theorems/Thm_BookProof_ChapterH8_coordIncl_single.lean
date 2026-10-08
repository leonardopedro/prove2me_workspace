-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.coordIncl_single
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Mathlib
import Definitions.Def_ChapterH8Bases
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap


theorem BookProof.ChapterH8.coordIncl_single {m n : ℕ} (hmn : m ≤ n) (i : Fin m) :
    coordIncl hmn (EuclideanSpace.single i (1 : ℂ))
      = EuclideanSpace.single (Fin.castLE hmn i) (1 : ℂ) := by sorry
