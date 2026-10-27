-- Generated from ChapterLorentzOrthochronous.lean — solution of BookProof.LorentzOrthochronous.lorentz_time_sq_ge_one
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Theorems.Thm_BookProof_LorentzOrthochronous_lorentz_time_col
open BookProof.LorentzOrthochronous




open Matrix
open BookProof.LorentzGroup

set_option maxHeartbeats 1000000 in
theorem solution {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    1 ≤ (l 0 0) ^ 2 := by

  have := lorentz_time_col h
  nlinarith [sq_nonneg (l 1 0), sq_nonneg (l 2 0), sq_nonneg (l 3 0)]
