-- Generated from ChapterLorentzOrthochronous.lean — solution of BookProof.LorentzOrthochronous.isPO_mul
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Theorems.Thm_BookProof_LorentzOrthochronous_orthochronous_mul
import Theorems.Thm_BookProof_LorentzGroup_isLorentz_mul
open BookProof.LorentzOrthochronous




open Matrix
open BookProof.LorentzGroup

set_option maxHeartbeats 1000000 in
theorem solution {a b : Matrix (Fin 4) (Fin 4) ℝ}
    (ha : IsProperOrthochronous a) (hb : IsProperOrthochronous b) :
    IsProperOrthochronous (a * b) := by

  obtain ⟨haL, had, ha0⟩ := ha
  obtain ⟨hbL, hbd, hb0⟩ := hb
  exact ⟨isLorentz_mul haL hbL, by rw [Matrix.det_mul, had, hbd]; ring,
    orthochronous_mul haL hbL ha0 hb0⟩
