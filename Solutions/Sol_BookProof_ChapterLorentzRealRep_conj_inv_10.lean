-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.conj_inv_10
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution : ∀ S ∈ Omega, ∀ i, S * b10 i * cinv S ∈ SB10 := by
 decide
