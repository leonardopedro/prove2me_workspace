-- Generated from PhysMehler.lean — solution of PhysMehler.admits_atomless_prior
import Mathlib
import Definitions.Def_PhysMehler
import Theorems.Thm_PhysFunctionalAnalysis_exists_atomless_sphere_measure
open PhysMehler



open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

set_option maxHeartbeats 1000000 in
theorem solution (E : Type*)
    [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    [MeasurableSpace E] [BorelSpace E] (e₀ e₁ : E) (h : Orthonormal ℝ ![e₀, e₁]) :
    ∃ μ : Measure E, IsProbabilityMeasure μ ∧ (∀ x, μ {x} = 0) ∧ ∀ᵐ v ∂μ, ‖v‖ = 1 := exists_atomless_sphere_measure E e₀ e₁ h
