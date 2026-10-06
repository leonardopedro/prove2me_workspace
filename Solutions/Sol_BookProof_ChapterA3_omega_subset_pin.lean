-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.omega_subset_pin
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaA0
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaA5
import Theorems.Thm_BookProof_ChapterA3_isPin_omegaG05
import Theorems.Thm_BookProof_ChapterA3_isPin_one
import Theorems.Thm_BookProof_ChapterA3_isPin_neg
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ∀ S ∈ OmegaPin, IsPin S := by

  intro S hS
  simp only [OmegaPin, Set.mem_insert_iff, Set.mem_singleton_iff] at hS
  rcases hS with h | h | h | h | h | h | h | h <;> subst h
  · exact isPin_one
  · simpa using isPin_neg isPin_one
  · exact isPin_omegaA0
  · exact isPin_neg isPin_omegaA0
  · exact isPin_omegaG05
  · exact isPin_neg isPin_omegaG05
  · exact isPin_omegaA5
  · exact isPin_neg isPin_omegaA5
