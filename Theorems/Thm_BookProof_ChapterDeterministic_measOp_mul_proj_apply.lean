-- Generated from ChapterDeterministic.lean — theorem BookProof.ChapterDeterministic.measOp_mul_proj_apply
import Definitions.Def_ChapterReconstruct
import Mathlib
import Definitions.Def_ChapterDeterministic
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterTimeTranslation
open BookProof.ChapterTimeTranslation
open BookProof.ChapterDeterministic


open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct BookProof.ChapterTimeTranslation


variable {n : ℕ}


theorem BookProof.ChapterDeterministic.measOp_mul_proj_apply (U : Matrix (Fin n) (Fin n) ℂ) (a b i j : Fin n) :
    (measOp U b * proj a) i j =
      if j = a then U i b * (starRingEnd ℂ) (U a b) else 0 := by sorry
