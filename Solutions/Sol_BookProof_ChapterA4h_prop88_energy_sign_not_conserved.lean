-- Generated from ChapterA4h.lean — solution of BookProof.ChapterA4h.prop88_energy_sign_not_conserved
import Mathlib
import Definitions.Def_ChapterA4h
import Theorems.Thm_BookProof_ChapterA4e_energy_sign_not_conserved
open BookProof.ChapterA4h



open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

variable (R : Type*)

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∀ j : Fin 3, projPos * spatialOp j = spatialOp j * projPos := by

  intro h
  obtain ⟨j, hj⟩ := energy_sign_not_conserved
  exact hj (h j)
