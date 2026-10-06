-- Generated from ChapterQuantumGravityHalfDensity.lean — theorem BookProof.QuantumGravityHalfDensity.qgSrcMeasure_eq_withDensity_halfDensity_sq
import Mathlib
import Definitions.Def_ChapterQuantumGravityHalfDensity
open BookProof.QuantumGravityHalfDensity



open MeasureTheory Set Filter
open scoped ENNReal

theorem BookProof.QuantumGravityHalfDensity.qgSrcMeasure_eq_withDensity_halfDensity_sq :
    qgSrcMeasure
      = (volume.restrict (Set.Ioi (0 : ℝ))).withDensity
          fun y => ENNReal.ofReal (qgHalfDensity y ^ 2) := by sorry
