-- Generated from ChapterAbelianDirectSum.lean — theorem BookProof.ChapterAbelianDirectSum.repInvariant_orthogonal
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterAbelianCyclicModel
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
open BookProof.ChapterAbelianDirectSum

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))


noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel


theorem BookProof.ChapterAbelianDirectSum.repInvariant_orthogonal {M : Submodule ℂ H} (hM : RepInvariant pi M) :
    RepInvariant pi Mᗮ := by sorry
