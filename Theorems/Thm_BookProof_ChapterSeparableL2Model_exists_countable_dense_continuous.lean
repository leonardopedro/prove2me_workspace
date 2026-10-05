-- Generated from ChapterSeparableL2Model.lean — theorem BookProof.ChapterSeparableL2Model.exists_countable_dense_continuous
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterAbelianCyclicModel
import Definitions.Def_ChapterAbelianDirectSum
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterStandardBorelClassification
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
open BookProof.ChapterSeparableL2Model

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]


noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterAbelianDirectSum BookProof.ChapterLinftyMultiplication
open BookProof.ChapterStandardBorelClassification

theorem BookProof.ChapterSeparableL2Model.exists_countable_dense_continuous [SeparableSpace (Lp ℂ 2 mu)] :
    ∃ D : Set C(Y, ℂ), D.Countable ∧
      Dense ((fun f : C(Y, ℂ) => ContinuousMap.toLp 2 mu ℂ f) '' D) := by sorry
