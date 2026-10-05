-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.gpF_empty
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Theorems.Thm_BookProof_ChapterPauliFundamental_sel_empty



open Matrix Finset



variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution (A : Fin 4 → M4) : gpF A ∅ = 1 := by

  rw [gpF, sel_empty]; rfl
