-- Generated from ChapterPaFreeCompletion.lean — solution of denseCore_dense
import Mathlib
import Definitions.Def_ChapterPaFreeCompletion
import Theorems.Thm_range_ofCore



open Set
open Filter
open BookProof.ChapterRieszFischer

set_option maxHeartbeats 1000000 in
theorem solution : Dense (Set.range ofCore) := by

  rw [range_ofCore]; exact finSupport_dense
