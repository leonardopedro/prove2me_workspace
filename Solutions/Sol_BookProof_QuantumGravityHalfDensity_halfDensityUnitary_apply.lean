-- Generated from ChapterQuantumGravityHalfDensity.lean — solution of BookProof.QuantumGravityHalfDensity.halfDensityUnitary_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravityHalfDensity
open BookProof.QuantumGravityHalfDensity




open MeasureTheory Set Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (g : Lp ℂ 2 (volume.restrict (Set.Ioi (0 : ℝ)))) :
    (halfDensityUnitary g : ℝ → ℂ) =ᵐ[qgSrcMeasure] fun y => (g : ℝ → ℂ) (y ^ 2) := Lp.coeFn_compMeasurePreserving _ measurePreserving_qgSquare
