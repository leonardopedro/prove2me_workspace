-- Generated from ChapterAbelianGelfandModel.lean — solution of BookProof.ChapterAbelianGelfandModel.toC_apply
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel



open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {X : Type*} [TopologicalSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (f : C(X, ℝ)) (x : X) : toC f x = (f x : ℂ) := rfl
