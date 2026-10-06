-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.lorentz_det_ne_zero
import Mathlib
import Definitions.Def_ChapterLorentzGroup
import Theorems.Thm_BookProof_LorentzGroup_lorentz_det_sq_one
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l.det ≠ 0 := by

      have := lorentz_det_sq_one h; aesop;
