-- Generated from ChapterAbelianDirectSum.lean — theorem BookProof.ChapterAbelianDirectSum.inner_eq_zero_of_orthogonalRepCyclicFamily
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterAbelianCyclicModel
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
open BookProof.ChapterAbelianDirectSum


noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))

variable (xi : H)
variable {pi}
variable (pi)

omit [CompactSpace X] [T2Space X] [MeasurableSpace X] [BorelSpace X] in
theorem BookProof.ChapterAbelianDirectSum.inner_eq_zero_of_orthogonalRepCyclicFamily {S : Set H}
    (hS : OrthogonalRepCyclicFamily pi S) {x y : H} (hx : x ∈ S) (hy : y ∈ S) (hxy : x ≠ y) :
    inner ℂ x y = (0 : ℂ) := by sorry
