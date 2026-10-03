-- Generated from ChapterAbelianGelfandModel.lean — theorem BookProof.ChapterAbelianGelfandModel.toC_apply
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {X : Type*} [TopologicalSpace X]


open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

theorem BookProof.ChapterAbelianGelfandModel.toC_apply (f : C(X, ℝ)) (x : X) : toC f x = (f x : ℂ) := by sorry
