-- Generated from PhysFunctionalAnalysis.lean — solution of PhysFunctionalAnalysis.l2_separable
import Mathlib
import Definitions.Def_PhysFunctionalAnalysis
open PhysFunctionalAnalysis



open MeasureTheory Set
open scoped ENNReal lp

noncomputable section


open PhysMeasureBasis

set_option maxHeartbeats 1000000 in
theorem solution :
    TopologicalSpace.SeparableSpace (Lp ℝ 2 unitMeasure) := by

  exact inferInstanceAs (TopologicalSpace.SeparableSpace (MeasureTheory.Lp ℝ 2
    (MeasureTheory.Measure.restrict (MeasureTheory.volume : MeasureTheory.Measure ℝ) (Set.Icc 0
    1))))
