-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.isPO_mul
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.isPO_mul {a b : Matrix (Fin 4) (Fin 4) ℝ}
    (ha : IsProperOrthochronous a) (hb : IsProperOrthochronous b) :
    IsProperOrthochronous (a * b) := by sorry
