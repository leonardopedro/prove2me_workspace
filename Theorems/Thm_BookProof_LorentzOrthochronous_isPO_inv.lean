-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.isPO_inv
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.isPO_inv {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsProperOrthochronous l) :
    IsProperOrthochronous l⁻¹ := by sorry
