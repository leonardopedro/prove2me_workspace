-- Generated from PhysMeasureBasis.lean — solution of PhysMeasureBasis.selection_exists
import Mathlib
import Definitions.Def_PhysMeasureBasis
open PhysMeasureBasis



open MeasureTheory Set ProbabilityTheory
open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    squareMeasure.fst ⊗ₘ squareMeasure.condKernel = squareMeasure := Measure.disintegrate _ _
