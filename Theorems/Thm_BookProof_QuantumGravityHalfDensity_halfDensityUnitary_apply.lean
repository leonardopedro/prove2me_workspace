-- Generated from ChapterQuantumGravityHalfDensity.lean — theorem BookProof.QuantumGravityHalfDensity.halfDensityUnitary_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravityHalfDensity
open BookProof.QuantumGravityHalfDensity



open MeasureTheory Set Filter
open scoped ENNReal

theorem BookProof.QuantumGravityHalfDensity.halfDensityUnitary_apply (g : Lp ℂ 2 (volume.restrict (Set.Ioi (0 : ℝ)))) :
    (halfDensityUnitary g : ℝ → ℂ) =ᵐ[qgSrcMeasure] fun y => (g : ℝ → ℂ) (y ^ 2) := by sorry
