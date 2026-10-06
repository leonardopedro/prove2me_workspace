-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.eta_det
import Mathlib
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : eta.det = -1 := by

  norm_num [ Matrix.det_succ_row_zero, eta ];
  simp [ Fin.sum_univ_succ ]
