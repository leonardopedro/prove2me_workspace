-- Generated from ChapterFreeFieldBornSignOrientationQuotient.lean — theorem BookProof.ChapterFreeFieldBornSignOrientationQuotient.orientationQuotientEquiv_mk
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignOrientationSubgroup
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationQuotient
open BookProof.ChapterFreeFieldBornSignOrientationQuotient


open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup

theorem BookProof.ChapterFreeFieldBornSignOrientationQuotient.orientationQuotientEquiv_mk (n : ℕ) (b : Fin (n + 1) → Bool) :
    orientationQuotientEquiv n (QuotientAddGroup.mk b) =
      orientationCharacter (n + 1) b := by sorry
