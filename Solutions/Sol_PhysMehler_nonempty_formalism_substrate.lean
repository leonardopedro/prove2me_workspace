-- Generated from PhysMehler.lean — solution of PhysMehler.nonempty_formalism_substrate
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
theorem solution : Nonempty (Formalism Substrate) := by

  obtain ⟨μ, h1, h2⟩ := exists_atomless_prob_substrate
  exact ⟨formalismOfPrior μ h1 h2⟩
