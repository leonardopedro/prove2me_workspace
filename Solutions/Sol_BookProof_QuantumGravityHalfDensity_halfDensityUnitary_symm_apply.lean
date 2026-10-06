-- Generated from ChapterQuantumGravityHalfDensity.lean — solution of BookProof.QuantumGravityHalfDensity.halfDensityUnitary_symm_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravityHalfDensity
open BookProof.QuantumGravityHalfDensity




open MeasureTheory Set Filter
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (h : Lp ℂ 2 qgSrcMeasure) :
    (halfDensityUnitary.symm h : ℝ → ℂ)
      =ᵐ[volume.restrict (Set.Ioi (0 : ℝ))] fun e => (h : ℝ → ℂ) (Real.sqrt e) := by

  have hsymm : halfDensityUnitary.symm h = halfDensityIsomInv h := by
    refine halfDensityUnitary.injective ?_
    rw [LinearIsometryEquiv.apply_symm_apply]
    exact (halfDensityIsom_halfDensityIsomInv h).symm
  rw [hsymm]
  exact Lp.coeFn_compMeasurePreserving _ measurePreserving_qgSqrt
