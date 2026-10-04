-- Generated from ChapterAbelianGelfandModel.lean — theorem BookProof.ChapterAbelianGelfandModel.realPartFunctional_ofReal
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4
open BookProof.ChapterAbelianGelfandModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {X : Type*} [TopologicalSpace X]


open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

theorem BookProof.ChapterAbelianGelfandModel.realPartFunctional_ofReal (psi : C(X, ℂ) →ₗ[ℂ] ℂ)
    (hpos : ∀ g : C(X, ℂ), 0 ≤ psi (star g * g)) (f : C(X, ℝ)) :
    psi (toC f) = (realPartFunctional psi f : ℂ) := by sorry
