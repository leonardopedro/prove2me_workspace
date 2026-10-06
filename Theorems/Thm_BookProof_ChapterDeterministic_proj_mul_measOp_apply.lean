-- Generated from ChapterDeterministic.lean — theorem BookProof.ChapterDeterministic.proj_mul_measOp_apply
import Definitions.Def_ChapterReconstruct
import Mathlib
import Definitions.Def_ChapterDeterministic
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterTimeTranslation
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterTimeTranslation
open BookProof.ChapterDeterministic

variable {n : ℕ}


open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct BookProof.ChapterTimeTranslation



theorem BookProof.ChapterDeterministic.proj_mul_measOp_apply (U : Matrix (Fin n) (Fin n) ℂ) (a b i j : Fin n) :
    (proj a * measOp U b) i j =
      if i = a then U a b * (starRingEnd ℂ) (U j b) else 0 := by sorry
