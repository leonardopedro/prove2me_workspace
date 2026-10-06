-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.isLorentz_eta
import Mathlib
import Definitions.Def_ChapterLorentzGroup
import Theorems.Thm_BookProof_LorentzGroup_eta_transpose
import Theorems.Thm_BookProof_LorentzGroup_eta_mul_self
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : IsLorentz eta := by

  simp only [IsLorentz, eta_transpose];
  rw [ eta_mul_self, Matrix.one_mul ]
