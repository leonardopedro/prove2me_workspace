-- Generated from ChapterLorentzOrthochronous.lean — solution of BookProof.LorentzOrthochronous.lorentz_inv_time
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Theorems.Thm_BookProof_LorentzOrthochronous_lorentz_inv_eq
open BookProof.LorentzOrthochronous




open Matrix
open BookProof.LorentzGroup

set_option maxHeartbeats 1000000 in
theorem solution {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l⁻¹ 0 0 = l 0 0 := by

  rw [lorentz_inv_eq h]
  simp [mul_apply, Fin.sum_univ_four, eta, vecMul, dotProduct]
