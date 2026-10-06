-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.lorentz_det_sq_one
import Mathlib
import Definitions.Def_ChapterLorentzGroup
import Theorems.Thm_BookProof_LorentzGroup_eta_det
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l.det ^ 2 = 1 := by

      unfold IsLorentz at h;
      apply_fun Matrix.det at h; norm_num [ eta_det ] at h; linarith;
