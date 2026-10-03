-- Generated from PhysFunctionalAnalysis.lean — theorem PhysFunctionalAnalysis.countable_of_separated
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
import Definitions.Def_ChapterA4
open PhysFunctionalAnalysis


open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

theorem PhysFunctionalAnalysis.countable_of_separated {X : Type*} [PseudoMetricSpace X]
    [TopologicalSpace.SeparableSpace X] {ι : Type*} (u : ι → X) {r : ℝ} (hr : 0 < r)
    (hsep : ∀ i j, i ≠ j → r ≤ dist (u i) (u j)) : Countable ι := by sorry
