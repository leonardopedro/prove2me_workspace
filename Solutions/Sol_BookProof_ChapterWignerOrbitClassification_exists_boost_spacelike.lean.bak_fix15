-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.exists_boost_spacelike
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
import Theorems.Thm_BookProof_ChapterWignerOrbitClassification_exists_boost_spacelike_of_pos
import Theorems.Thm_BookProof_ChapterWignerOrbitClassification_exists_boost_spacelike_of_neg
import Theorems.Thm_BookProof_ChapterWignerOrbitClassification_exists_boost_spacelike_of_zero
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution {m : ℝ} (hm : 0 < m) (p : Fin 4 → ℝ)
    (hshell : minkSq p = -m ^ 2) :
    ∃ A : Matrix (Fin 2) (Fin 2) ℂ, A.det = 1 ∧
      act A (hermOfMom (spaceRefMom m)) = hermOfMom p := by

  rcases lt_trichotomy (p 0 + p 3) 0 with h | h | h
  · exact exists_boost_spacelike_of_neg hm p hshell h
  · exact exists_boost_spacelike_of_zero hm p hshell h
  · exact exists_boost_spacelike_of_pos hm p hshell h
