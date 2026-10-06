-- Generated from ChapterLorentzOrthochronous.lean — solution of BookProof.LorentzOrthochronous.isLorentz_neg
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
open BookProof.LorentzOrthochronous




open Matrix
open BookProof.LorentzGroup

set_option maxHeartbeats 1000000 in
theorem solution {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    IsLorentz (-l) := by

  unfold IsLorentz at *
  simp only [transpose_neg, neg_mul, mul_neg, neg_neg]
  exact h
