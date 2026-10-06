-- Generated from ChapterQuantumGravityHalfDensity.lean — theorem BookProof.QuantumGravityHalfDensity.halfDensityUnitary_symm_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravityHalfDensity
open BookProof.QuantumGravityHalfDensity



open MeasureTheory Set Filter
open scoped ENNReal

theorem BookProof.QuantumGravityHalfDensity.halfDensityUnitary_symm_apply (h : Lp ℂ 2 qgSrcMeasure) :
    (halfDensityUnitary.symm h : ℝ → ℂ)
      =ᵐ[volume.restrict (Set.Ioi (0 : ℝ))] fun e => (h : ℝ → ℂ) (Real.sqrt e) := by sorry
