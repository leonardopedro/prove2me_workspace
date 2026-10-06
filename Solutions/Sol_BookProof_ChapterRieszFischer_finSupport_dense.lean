-- Generated from ChapterRieszFischer.lean — solution of BookProof.ChapterRieszFischer.finSupport_dense
import Mathlib
import Definitions.Def_ChapterRieszFischer
import Theorems.Thm_BookProof_ChapterRieszFischer_riesz_fischer_hasSum
import Theorems.Thm_BookProof_ChapterRieszFischer_sum_single_mem_finSupport
open BookProof.ChapterRieszFischer



open Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : Dense FinSupport := by

  intro f
  refine mem_closure_of_tendsto (riesz_fischer_hasSum f) ?_
  filter_upwards with s using sum_single_mem_finSupport f s
