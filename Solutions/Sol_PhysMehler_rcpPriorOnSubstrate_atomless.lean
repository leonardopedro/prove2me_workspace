-- Generated from PhysMehler.lean — solution of PhysMehler.rcpPriorOnSubstrate_atomless
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

set_option maxHeartbeats 1000000 in
theorem solution : ∀ x : Substrate, rcpPriorOnSubstrate {x} = 0 := (Classical.choose_spec exists_atomless_prob_substrate).2
