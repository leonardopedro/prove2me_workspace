-- Generated from ChapterRieszFischer.lean — solution of BookProof.ChapterRieszFischer.finSupport_ne_univ
import Mathlib
import Definitions.Def_ChapterRieszFischer
import Theorems.Thm_BookProof_ChapterRieszFischer_geomVec_not_mem_finSupport
open BookProof.ChapterRieszFischer



open Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : FinSupport ≠ (Set.univ : Set Ell2) := by

  intro h
  exact geomVec_not_mem_finSupport (h ▸ Set.mem_univ geomVec)
