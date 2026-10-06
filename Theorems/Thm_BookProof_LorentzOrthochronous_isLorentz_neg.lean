-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.isLorentz_neg
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.isLorentz_neg {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    IsLorentz (-l) := by sorry
