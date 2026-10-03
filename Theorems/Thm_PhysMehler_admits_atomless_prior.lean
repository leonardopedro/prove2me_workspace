-- Generated from PhysMehler.lean — theorem PhysMehler.admits_atomless_prior
import Mathlib
import Definitions.Def_PhysMehler
import Definitions.Def_ChapterA4
open PhysMehler


open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

theorem PhysMehler.admits_atomless_prior (E : Type*)
    [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    [MeasurableSpace E] [BorelSpace E] (e₀ e₁ : E) (h : Orthonormal ℝ ![e₀, e₁]) :
    ∃ μ : Measure E, IsProbabilityMeasure μ ∧ (∀ x, μ {x} = 0) ∧ ∀ᵐ v ∂μ, ‖v‖ = 1 := by sorry
