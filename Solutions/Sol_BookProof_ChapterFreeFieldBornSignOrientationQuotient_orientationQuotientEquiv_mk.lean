-- Generated from ChapterFreeFieldBornSignOrientationQuotient.lean — solution of BookProof.ChapterFreeFieldBornSignOrientationQuotient.orientationQuotientEquiv_mk
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationQuotient
open BookProof.ChapterFreeFieldBornSignOrientationQuotient



open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (b : Fin (n + 1) → Bool) :
    orientationQuotientEquiv n (QuotientAddGroup.mk b) =
      orientationCharacter (n + 1) b := by

  convert QuotientAddGroup.kerLift_mk (orientationCharacter (n + 1)) b using 1
  rfl
