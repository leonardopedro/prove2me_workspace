-- Generated from ChapterPaFreeCompletion.lean — solution of denseCore_proper
import Mathlib
import Definitions.Def_ChapterPaFreeCompletion
import Theorems.Thm_range_ofCore



open Set
open Filter
open BookProof.ChapterRieszFischer

set_option maxHeartbeats 1000000 in
theorem solution : Set.range ofCore ≠ (Set.univ : Set Ell2) := by

  rw [range_ofCore]; exact finSupport_ne_univ
