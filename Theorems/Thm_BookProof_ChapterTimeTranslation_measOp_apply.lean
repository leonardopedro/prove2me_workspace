-- Generated from ChapterTimeTranslation.lean — theorem BookProof.ChapterTimeTranslation.measOp_apply
import Definitions.Def_ChapterReconstruct
import Mathlib
import Definitions.Def_ChapterTimeTranslation
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterTimeTranslation

variable {n : ℕ}


open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct



theorem BookProof.ChapterTimeTranslation.measOp_apply (U : Matrix (Fin n) (Fin n) ℂ) (a : Fin n) (k l : Fin n) :
    measOp U a k l = U k a * (starRingEnd ℂ) (U l a) := by sorry
