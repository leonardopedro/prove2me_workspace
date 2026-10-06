-- Generated from ChapterFreeEMField.lean — theorem BookProof.FreeEMField.Fbook_eq_emFieldStrength_of_commute
import Mathlib
import Definitions.Def_ChapterFreeEMField
import Definitions.Def_ChapterYangMillsFieldStrength
open BookProof.YangMillsFieldStrength
open BookProof.FreeEMField

variable {R : Type*} [Ring R]
variable {R : Type*} [Ring R] [Algebra ℂ R]



open BookProof.YangMillsFieldStrength



theorem BookProof.FreeEMField.Fbook_eq_emFieldStrength_of_commute
    (δ : Fin 3 → R → R) (g : ℝ) (A : Fin 3 → R)
    (hcommute : ∀ j k, A j * A k = A k * A j) (j k : Fin 3) :
    Fbook δ g A j k = emFieldStrength δ A j k := by sorry
