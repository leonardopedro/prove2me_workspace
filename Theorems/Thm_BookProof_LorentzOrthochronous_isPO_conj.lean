-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.isPO_conj
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.isPO_conj {g s : Matrix (Fin 4) (Fin 4) ℝ}
    (hg : IsLorentz g) (hs : IsProperOrthochronous s) :
    IsProperOrthochronous (g * s * g⁻¹) := by sorry
