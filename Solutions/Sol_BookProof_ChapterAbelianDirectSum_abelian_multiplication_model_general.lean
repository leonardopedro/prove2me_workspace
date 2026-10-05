-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.abelian_multiplication_model_general
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_exists_rep_cyclic_decomposition
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_range_repEmbedding
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_repEmbedding_intertwines
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_orthogonalFamily_repEmbedding
import Theorems.Thm_BookProof_ChapterAbelianCyclicModel_isProbabilityMeasure_repMeasure
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
variable (pi)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (S : Set H) (mu : S → Measure X) (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (g : C(X, ℂ)) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) g u) = pi g (V x u)) := by

  obtain ⟨S, hS, htop⟩ := exists_rep_cyclic_decomposition pi
  refine ⟨S, fun x => repMeasure pi (x : H), fun x => repEmbedding pi (x : H),
    fun x => isProbabilityMeasure_repMeasure pi (x : H) (hS.1 (x : H) x.2), ?_,
    fun x g u => repEmbedding_intertwines pi (x : H) g u⟩
  refine IsHilbertSum.mk (orthogonalFamily_repEmbedding hS) ?_
  have hrange : (⨆ x : S, LinearMap.range (repEmbedding pi (x : H)).toLinearMap)
      = ⨆ x ∈ S, repCyclicSubspace pi x := by
    rw [iSup_subtype]
    exact iSup_congr fun x => iSup_congr fun _ => range_repEmbedding pi x
  rw [hrange, htop]
