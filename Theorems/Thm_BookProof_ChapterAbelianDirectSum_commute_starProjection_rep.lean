-- Generated from ChapterAbelianDirectSum.lean — theorem BookProof.ChapterAbelianDirectSum.commute_starProjection_rep
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


omit [CompactSpace X] [T2Space X] [MeasurableSpace X] [BorelSpace X] in
theorem BookProof.ChapterAbelianDirectSum.commute_starProjection_rep {M : Submodule ℂ H} [M.HasOrthogonalProjection]
    (hM : RepInvariant pi M) (g : C(X, ℂ)) :
    Commute M.starProjection (pi g) := by sorry
