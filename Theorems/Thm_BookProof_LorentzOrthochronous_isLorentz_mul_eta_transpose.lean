-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.isLorentz_mul_eta_transpose
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.isLorentz_mul_eta_transpose {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l * eta * lᵀ = eta := by sorry
