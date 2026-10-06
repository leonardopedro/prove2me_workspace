-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.delta_involutive
import Mathlib
import Definitions.Def_ChapterLorentzGroup
import Theorems.Thm_BookProof_LorentzGroup_eta_mul_self
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ∀ x ∈ Delta, x * x = 1 := by

  rintro x ( rfl | rfl | rfl | rfl ) <;> norm_num [ eta_mul_self ]
