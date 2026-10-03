-- Generated from PhysFunctionalAnalysis.lean — theorem PhysFunctionalAnalysis.linf_not_separable
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis
open PhysFunctionalAnalysis


open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

theorem PhysFunctionalAnalysis.linf_not_separable :
    ¬ TopologicalSpace.SeparableSpace (Lp ℝ ⊤ unitMeasure) := by sorry
