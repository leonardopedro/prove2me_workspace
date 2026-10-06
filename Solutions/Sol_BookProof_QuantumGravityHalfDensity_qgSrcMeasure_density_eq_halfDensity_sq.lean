-- Generated from ChapterQuantumGravityHalfDensity.lean — solution of BookProof.QuantumGravityHalfDensity.qgSrcMeasure_density_eq_halfDensity_sq
import Mathlib
import Definitions.Def_ChapterQuantumGravityHalfDensity
open BookProof.QuantumGravityHalfDensity




open MeasureTheory Set Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {y : ℝ} (hy : 0 ≤ y) :
    qgHalfDensity y ^ 2 = qgJacobian y := Real.sq_sqrt (by simpa [qgJacobian] using (by linarith : (0:ℝ) ≤ 2 * y))
