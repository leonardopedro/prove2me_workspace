-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.conj_inv_two
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ S ∈ Omega, ∀ i, S * w2 i * cinv S ∈ SW2 := by
 decide
