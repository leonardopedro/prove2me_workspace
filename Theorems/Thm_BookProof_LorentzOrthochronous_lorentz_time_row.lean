-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.lorentz_time_row
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.lorentz_time_row {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    (l 0 0) ^ 2 = 1 + (l 0 1) ^ 2 + (l 0 2) ^ 2 + (l 0 3) ^ 2 := by sorry
