-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.product_time_component
import Definitions.Def_ChapterLorentzGroup
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.product_time_component (a b : Matrix (Fin 4) (Fin 4) ℝ) :
    (a * b) 0 0 = a 0 0 * b 0 0 + a 0 1 * b 1 0 + a 0 2 * b 2 0 + a 0 3 * b 3 0 := by sorry
