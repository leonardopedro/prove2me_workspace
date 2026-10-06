-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.cinv_correct
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution : ∀ S ∈ Omega, S * cinv S = 1 := by
 decide
