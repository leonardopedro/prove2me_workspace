-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.lorentz_inv_eq
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.lorentz_inv_eq {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l⁻¹ = eta * lᵀ * eta := by sorry
