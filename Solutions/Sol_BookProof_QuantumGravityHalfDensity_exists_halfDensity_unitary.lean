-- Generated from ChapterQuantumGravityHalfDensity.lean — solution of BookProof.QuantumGravityHalfDensity.exists_halfDensity_unitary
import Mathlib
import Definitions.Def_ChapterQuantumGravityHalfDensity
open BookProof.QuantumGravityHalfDensity




open MeasureTheory Set Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ _W : Lp ℂ 2 (volume.restrict (Set.Ioi (0 : ℝ))) ≃ₗᵢ[ℂ] Lp ℂ 2 qgSrcMeasure, True := ⟨halfDensityUnitary, trivial⟩
