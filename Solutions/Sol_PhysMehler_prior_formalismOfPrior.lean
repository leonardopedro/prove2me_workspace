-- Generated from PhysMehler.lean — solution of PhysMehler.prior_formalismOfPrior
import Mathlib
import Definitions.Def_PhysMehler
open PhysMehler



open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure Substrate)
    (h1 : IsProbabilityMeasure μ) (h2 : ∀ x, μ {x} = 0) :
    (formalismOfPrior μ h1 h2).prior = μ := rfl
