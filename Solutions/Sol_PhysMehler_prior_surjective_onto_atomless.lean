-- Generated from PhysMehler.lean — solution of PhysMehler.prior_surjective_onto_atomless
import Mathlib
import Definitions.Def_PhysMehler
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMehler



open MeasureTheory Set Filter TopologicalSpace
open scoped ENNReal Topology BigOperators

noncomputable section


open PhysMeasureBasis PhysFunctionalAnalysis PhysHSGaussian
open PhysMeasureBasis

/-- The source chapter equips the substrate with its Borel σ-algebra as a *local*
instance, so it is not exported with the published bundle; re-declare it here. -/
noncomputable local instance substrateMeasurableSpace : MeasurableSpace Substrate := borel _

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure Substrate)
    (h1 : IsProbabilityMeasure μ) (h2 : ∀ x, μ {x} = 0) :
    ∃ F : Formalism Substrate, F.prior = μ := ⟨formalismOfPrior μ h1 h2, rfl⟩
