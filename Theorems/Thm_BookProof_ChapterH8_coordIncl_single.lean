-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.coordIncl_single
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

theorem BookProof.ChapterH8.coordIncl_single {m n : ℕ} (hmn : m ≤ n) (i : Fin m) :
    coordIncl hmn (EuclideanSpace.single i (1 : ℂ))
      = EuclideanSpace.single (Fin.castLE hmn i) (1 : ℂ) := by sorry
