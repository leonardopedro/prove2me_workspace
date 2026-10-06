-- Generated from ChapterRieszFischer.lean — solution of BookProof.ChapterRieszFischer.core_proper_and_dense
import Mathlib
import Definitions.Def_ChapterRieszFischer
import Theorems.Thm_BookProof_ChapterRieszFischer_finSupport_dense
import Theorems.Thm_BookProof_ChapterRieszFischer_finSupport_ne_univ
open BookProof.ChapterRieszFischer



open Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense FinSupport ∧ FinSupport ≠ (Set.univ : Set Ell2) := ⟨finSupport_dense, finSupport_ne_univ⟩
