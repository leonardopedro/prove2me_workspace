-- Generated from ChapterGaugeMechanicsCharge.lean — solution of BookProof.ChapterGaugeMechanicsCharge.brst_ne_zero
import Mathlib
import Definitions.Def_ChapterGaugeMechanicsCharge
import Theorems.Thm_BookProof_ChapterGaugeMechanicsCharge_chargeQ_ne_zero
open BookProof.ChapterGaugeMechanicsCharge





open MvPolynomial

set_option maxHeartbeats 1000000 in
theorem solution : brstOmega ≠ 0 := by

  intro h
  apply chargeQ_ne_zero
  have := congrFun (congrFun h 1) 0
  simpa [brstOmega, ChapterG.BRST] using this
