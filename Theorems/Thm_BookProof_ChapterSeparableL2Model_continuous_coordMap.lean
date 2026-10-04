-- Generated from ChapterSeparableL2Model.lean — theorem BookProof.ChapterSeparableL2Model.continuous_coordMap
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterA4
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterSeparableL2Model

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [MeasurableSpace Y]
  [BorelSpace Y] (D : Set C(Y, ℂ)) [Countable D]


noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterStandardBorelClassification

omit [CompactSpace Y] [MeasurableSpace Y] [BorelSpace Y] [Countable D] in
theorem BookProof.ChapterSeparableL2Model.continuous_coordMap : Continuous (coordMap D) := by sorry
