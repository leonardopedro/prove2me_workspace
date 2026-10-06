-- Generated from ChapterLorentzOrthochronous.lean — solution of BookProof.LorentzOrthochronous.lorentz_inv_eq
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Theorems.Thm_BookProof_LorentzGroup_eta_mul_self
open BookProof.LorentzOrthochronous




open Matrix
open BookProof.LorentzGroup

set_option maxHeartbeats 1000000 in
theorem solution {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l⁻¹ = eta * lᵀ * eta := by

  apply Matrix.inv_eq_left_inv
  have : (eta * lᵀ * eta) * l = eta * (lᵀ * eta * l) := by simp [Matrix.mul_assoc]
  rw [this, h, eta_mul_self]
