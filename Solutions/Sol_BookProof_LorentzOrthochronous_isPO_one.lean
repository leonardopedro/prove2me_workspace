-- Generated from ChapterLorentzOrthochronous.lean — solution of BookProof.LorentzOrthochronous.isPO_one
import Mathlib
import Definitions.Def_ChapterLorentzOrthochronous
import Theorems.Thm_BookProof_LorentzGroup_isLorentz_one
open BookProof.LorentzOrthochronous




open Matrix
open BookProof.LorentzGroup

set_option maxHeartbeats 1000000 in
theorem solution : IsProperOrthochronous 1 := ⟨isLorentz_one, by simp, by simp⟩
