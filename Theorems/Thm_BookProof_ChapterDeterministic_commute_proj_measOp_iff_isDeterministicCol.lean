-- Generated from ChapterDeterministic.lean — theorem BookProof.ChapterDeterministic.commute_proj_measOp_iff_isDeterministicCol
import Mathlib
import Definitions.Def_ChapterDeterministic
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterReconstruct
import Definitions.Def_ChapterTimeTranslation
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterReconstruct
open BookProof.ChapterTimeTranslation
open BookProof.ChapterDeterministic

variable {n : ℕ}


open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct BookProof.ChapterTimeTranslation



theorem BookProof.ChapterDeterministic.commute_proj_measOp_iff_isDeterministicCol
    (U : Matrix (Fin n) (Fin n) ℂ) (b : Fin n) :
    (∀ a : Fin n, Commute (proj a) (measOp U b)) ↔ IsDeterministicCol U b := by sorry
