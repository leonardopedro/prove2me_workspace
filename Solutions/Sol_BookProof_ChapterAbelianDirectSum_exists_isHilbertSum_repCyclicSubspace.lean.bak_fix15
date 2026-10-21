-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.exists_isHilbertSum_repCyclicSubspace
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_exists_rep_cyclic_decomposition
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

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ S : Set H, OrthogonalRepCyclicFamily pi S ∧
      IsHilbertSum ℂ (fun x : S => (repCyclicSubspace pi (x : H)))
        (fun x : S => (repCyclicSubspace pi (x : H)).subtypeₗᵢ) := by

  obtain ⟨S, hS, htop⟩ := exists_rep_cyclic_decomposition pi
  exact ⟨S, hS, isHilbertSum_repCyclicSubspace pi hS htop⟩
