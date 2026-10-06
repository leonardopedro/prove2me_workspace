-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.orthochronous_mul
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.orthochronous_mul {a b : Matrix (Fin 4) (Fin 4) ℝ}
    (ha : IsLorentz a) (hb : IsLorentz b) (h0a : 0 < a 0 0) (h0b : 0 < b 0 0) :
    0 < (a * b) 0 0 := by sorry
