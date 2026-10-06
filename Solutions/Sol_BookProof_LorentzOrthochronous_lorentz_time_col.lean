-- Generated from ChapterLorentzOrthochronous.lean — solution of BookProof.LorentzOrthochronous.lorentz_time_col
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
open BookProof.LorentzOrthochronous




open Matrix
open BookProof.LorentzGroup

set_option maxHeartbeats 1000000 in
theorem solution {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    (l 0 0) ^ 2 = 1 + (l 1 0) ^ 2 + (l 2 0) ^ 2 + (l 3 0) ^ 2 := by

  have h00 := congr_fun (congr_fun h 0) 0
  simp [mul_apply, Fin.sum_univ_four, eta] at h00
  ring_nf at h00 ⊢
  linarith [h00]
