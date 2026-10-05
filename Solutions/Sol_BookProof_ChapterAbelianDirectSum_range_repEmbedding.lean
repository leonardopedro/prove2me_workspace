-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.range_repEmbedding
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_mem_repCyclicSubspace_repEmbedding
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

set_option maxHeartbeats 1000000 in
theorem solution :
    LinearMap.range (repEmbedding pi xi).toLinearMap = repCyclicSubspace pi xi := by

  apply le_antisymm
  · rintro _ ⟨u, rfl⟩
    exact mem_repCyclicSubspace_repEmbedding pi xi u
  · intro v hv
    refine ⟨(repCyclicUnitary pi xi).symm ⟨v, hv⟩, ?_⟩
    change (repCyclicUnitary pi xi ((repCyclicUnitary pi xi).symm ⟨v, hv⟩) : H) = v
    rw [LinearIsometryEquiv.apply_symm_apply]
