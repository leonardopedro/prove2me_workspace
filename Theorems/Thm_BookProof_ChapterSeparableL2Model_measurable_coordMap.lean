-- Generated from ChapterSeparableL2Model.lean — theorem BookProof.ChapterSeparableL2Model.measurable_coordMap
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterAbelianCyclicModel
import Definitions.Def_ChapterAbelianDirectSum
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterStandardBorelClassification
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterSeparableL2Model

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [MeasurableSpace Y]
  [BorelSpace Y] (D : Set C(Y, ℂ)) [Countable D]


noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterAbelianDirectSum BookProof.ChapterLinftyMultiplication
open BookProof.ChapterStandardBorelClassification

theorem BookProof.ChapterSeparableL2Model.measurable_coordMap : Measurable (coordMap D) := by sorry
