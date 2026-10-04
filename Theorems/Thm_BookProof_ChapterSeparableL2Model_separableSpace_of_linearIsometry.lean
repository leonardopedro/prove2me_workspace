-- Generated from ChapterSeparableL2Model.lean — theorem BookProof.ChapterSeparableL2Model.separableSpace_of_linearIsometry
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
import Definitions.Def_ChapterA4
open BookProof.ChapterSeparableL2Model

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [MeasurableSpace Y]
  [BorelSpace Y] (D : Set C(Y, ℂ)) [Countable D]
variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsProbabilityMeasure mu] [mu.WeaklyRegular]
variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterStandardBorelClassification

theorem BookProof.ChapterSeparableL2Model.separableSpace_of_linearIsometry [SeparableSpace H] {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℂ E] (V : E →ₗᵢ[ℂ] H) : SeparableSpace E := by sorry
