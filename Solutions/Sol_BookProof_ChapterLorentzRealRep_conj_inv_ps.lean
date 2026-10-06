-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.conj_inv_ps
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution : ∀ S ∈ Omega, ∀ i, S * bPs i * cinv S ∈ SBPs := by
 decide
