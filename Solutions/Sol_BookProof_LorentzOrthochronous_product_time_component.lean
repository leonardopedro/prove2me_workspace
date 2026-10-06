-- Generated from ChapterLorentzOrthochronous.lean — solution of BookProof.LorentzOrthochronous.product_time_component
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
open BookProof.LorentzOrthochronous




open Matrix
open BookProof.LorentzGroup

set_option maxHeartbeats 1000000 in
theorem solution (a b : Matrix (Fin 4) (Fin 4) ℝ) :
    (a * b) 0 0 = a 0 0 * b 0 0 + a 0 1 * b 1 0 + a 0 2 * b 2 0 + a 0 3 * b 3 0 := by

  simp [mul_apply, Fin.sum_univ_four]
