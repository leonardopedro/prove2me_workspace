-- Generated from ChapterDoubleSlit.lean — solution of BookProof.ChapterDoubleSlit.slit_open_born
import Mathlib
import Definitions.Def_ChapterDoubleSlit
import Theorems.Thm_BookProof_ChapterDoubleSlit_slit_open_state
open BookProof.ChapterDoubleSlit



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution :
    bornProb (H *ᵥ (H *ᵥ psi0)) 0 = 1 ∧ bornProb (H *ᵥ (H *ᵥ psi0)) 1 = 0 := by

  rw [slit_open_state]
  refine ⟨?_, ?_⟩ <;> simp [bornProb, psi0]
