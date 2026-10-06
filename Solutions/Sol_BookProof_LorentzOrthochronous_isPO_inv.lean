-- Generated from ChapterLorentzOrthochronous.lean — solution of BookProof.LorentzOrthochronous.isPO_inv
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Theorems.Thm_BookProof_LorentzOrthochronous_lorentz_inv_time
import Theorems.Thm_BookProof_LorentzGroup_isLorentz_inv
open BookProof.LorentzOrthochronous




open Matrix
open BookProof.LorentzGroup

set_option maxHeartbeats 1000000 in
theorem solution {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsProperOrthochronous l) :
    IsProperOrthochronous l⁻¹ := by

  obtain ⟨hL, hd, h0⟩ := h
  refine ⟨isLorentz_inv hL, ?_, ?_⟩
  · rw [Matrix.det_nonsing_inv, hd]; simp
  · rw [lorentz_inv_time hL]; exact h0
