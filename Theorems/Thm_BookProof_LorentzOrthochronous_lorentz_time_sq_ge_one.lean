-- Generated from ChapterLorentzOrthochronous.lean — theorem BookProof.LorentzOrthochronous.lorentz_time_sq_ge_one
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous



open Matrix
open BookProof.LorentzGroup

theorem BookProof.LorentzOrthochronous.lorentz_time_sq_ge_one {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    1 ≤ (l 0 0) ^ 2 := by sorry
