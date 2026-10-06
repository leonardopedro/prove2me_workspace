-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.eta_transpose
import Mathlib
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : etaᵀ = eta := by

  ext i j; fin_cases i <;> fin_cases j <;> rfl;
