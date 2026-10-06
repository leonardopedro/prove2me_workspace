-- Generated from ChapterDeterministic.lean — theorem BookProof.ChapterDeterministic.measOpSet_eq_sum
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



theorem BookProof.ChapterDeterministic.measOpSet_eq_sum (U : Matrix (Fin n) (Fin n) ℂ) (B : Finset (Fin n)) :
    measOpSet U B = ∑ b ∈ B, measOp U b := by sorry
