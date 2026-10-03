-- Generated from PhysMehler.lean — theorem PhysMehler.prior_formalismOfPrior
import Mathlib
import Definitions.Def_PhysMehler
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis
open PhysMehler


open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

theorem PhysMehler.prior_formalismOfPrior (μ : Measure Substrate)
    (h1 : IsProbabilityMeasure μ) (h2 : ∀ x, μ {x} = 0) :
    (formalismOfPrior μ h1 h2).prior = μ := by sorry
