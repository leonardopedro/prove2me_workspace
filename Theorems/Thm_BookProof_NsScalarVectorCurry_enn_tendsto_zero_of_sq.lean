-- Generated from ChapterNsScalarVectorCurry.lean — theorem BookProof.NsScalarVectorCurry.enn_tendsto_zero_of_sq
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
open BookProof.NsScalarVectorCurry

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]


open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section


theorem BookProof.NsScalarVectorCurry.enn_tendsto_zero_of_sq {u : ℕ → ℝ≥0∞}
    (h : Filter.Tendsto (fun k => u k ^ 2) Filter.atTop (nhds 0)) :
    Filter.Tendsto u Filter.atTop (nhds 0) := by sorry
