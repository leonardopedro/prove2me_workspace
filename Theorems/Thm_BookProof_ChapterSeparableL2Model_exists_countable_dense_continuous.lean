-- Generated from ChapterSeparableL2Model.lean — theorem BookProof.ChapterSeparableL2Model.exists_countable_dense_continuous
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
import Definitions.Def_ChapterA4
open BookProof.ChapterSeparableL2Model

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]


noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterStandardBorelClassification

theorem BookProof.ChapterSeparableL2Model.exists_countable_dense_continuous [SeparableSpace (Lp ℂ 2 mu)] :
    ∃ D : Set C(Y, ℂ), D.Countable ∧
      Dense ((fun f : C(Y, ℂ) => ContinuousMap.toLp 2 mu ℂ f) '' D) := by sorry
