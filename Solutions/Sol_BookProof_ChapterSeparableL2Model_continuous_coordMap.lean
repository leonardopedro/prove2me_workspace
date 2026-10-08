-- Generated from ChapterSeparableL2Model.lean — solution of BookProof.ChapterSeparableL2Model.continuous_coordMap
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
open BookProof.ChapterSeparableL2Model



noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterAbelianDirectSum BookProof.ChapterLinftyMultiplication
open BookProof.ChapterStandardBorelClassification

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [MeasurableSpace Y]
  [BorelSpace Y] (D : Set C(Y, ℂ)) [Countable D]

set_option maxHeartbeats 1000000 in
theorem solution : Continuous (coordMap D) :=
  continuous_pi fun d => (d : C(Y, ℂ)).continuous
  
  omit [CompactSpace Y] in
