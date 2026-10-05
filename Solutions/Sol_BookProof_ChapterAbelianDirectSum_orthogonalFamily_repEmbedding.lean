-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.orthogonalFamily_repEmbedding
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_mem_repCyclicSubspace_repEmbedding
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_inner_eq_zero_of_le_orthogonal
open BookProof.ChapterAbelianDirectSum



noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))
variable (xi : H)
variable {pi}

set_option maxHeartbeats 1000000 in
theorem solution {S : Set H} (hS : OrthogonalRepCyclicFamily pi S) :
    OrthogonalFamily ℂ (fun x : S => Lp ℂ 2 (repMeasure pi (x : H)))
      (fun x : S => repEmbedding pi (x : H)) := by

  intro x y hxy u v
  have hle := hS.2 (x : H) x.2 (y : H) y.2 (Subtype.coe_injective.ne hxy)
  exact inner_eq_zero_of_le_orthogonal hle
    (mem_repCyclicSubspace_repEmbedding pi (x : H) u)
    (mem_repCyclicSubspace_repEmbedding pi (y : H) v)
