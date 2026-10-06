-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.lorentz_time_col
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.lorentz_time_col {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    (l 0 0) ^ 2 = 1 + (l 1 0) ^ 2 + (l 2 0) ^ 2 + (l 3 0) ^ 2 := by sorry
