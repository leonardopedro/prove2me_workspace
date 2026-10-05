-- Generated from PhysMehler.lean — solution of PhysMehler.model_has_prior
import Mathlib
import Definitions.Def_PhysMehler
open PhysMehler



open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian

set_option maxHeartbeats 1000000 in
theorem solution {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℝ H]
    [CompleteSpace H] [MeasurableSpace H] (F : Formalism H) :
    IsProbabilityMeasure F.prior ∧ ∀ x, F.prior {x} = 0 := ⟨F.prior_isProb, F.prior_atomless⟩
