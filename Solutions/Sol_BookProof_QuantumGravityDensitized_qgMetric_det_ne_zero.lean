-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.qgMetric_det_ne_zero
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_qgMetric_det
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : (qgMetric n).det ≠ 0 := by

  rw [qgMetric_det]
  refine Finset.prod_ne_zero_iff.mpr fun i _ => ?_
  by_cases h : i = Fin.last n <;> simp [h]
