-- Generated from ChapterRieszFischer.lean — solution of BookProof.ChapterRieszFischer.geomVec_not_mem_finSupport
import Mathlib
import Definitions.Def_ChapterRieszFischer
open BookProof.ChapterRieszFischer



open Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : geomVec ∉ FinSupport := by

  intro h
  simp only [FinSupport, Set.mem_setOf_eq] at h
  have hsupp : Function.support ((geomVec : ℕ → ℝ)) = Set.univ := by
    ext n
    simp [geomVec, Function.mem_support]
  rw [hsupp] at h
  exact Set.infinite_univ h
