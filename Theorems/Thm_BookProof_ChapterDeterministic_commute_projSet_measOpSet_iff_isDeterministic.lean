-- Generated from ChapterDeterministic.lean — theorem BookProof.ChapterDeterministic.commute_projSet_measOpSet_iff_isDeterministic
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



theorem BookProof.ChapterDeterministic.commute_projSet_measOpSet_iff_isDeterministic
    (U : Matrix (Fin n) (Fin n) ℂ) :
    (∀ A B : Finset (Fin n), Commute (projSet A) (measOpSet U B)) ↔ IsDeterministic U := by sorry
