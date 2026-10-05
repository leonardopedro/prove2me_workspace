-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.repInvariant_iSup_repCyclicSubspace
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_repInvariant_repCyclicSubspace
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
omit [CompactSpace X] [T2Space X] [MeasurableSpace X] [BorelSpace X] in
theorem solution (S : Set H) :
    RepInvariant pi (⨆ x ∈ S, repCyclicSubspace pi x).topologicalClosure := by

  intro g v hv
  have hle : (⨆ x ∈ S, repCyclicSubspace pi x)
      ≤ ((⨆ x ∈ S, repCyclicSubspace pi x).topologicalClosure).comap (pi g).toLinearMap := by
    refine iSup_le fun x => iSup_le fun hx => ?_
    intro w hw
    simp only [Submodule.mem_comap, ContinuousLinearMap.coe_coe]
    refine Submodule.le_topologicalClosure _ ?_
    have : pi g w ∈ repCyclicSubspace pi x := repInvariant_repCyclicSubspace pi x g w hw
    exact le_iSup₂ (f := fun x (_ : x ∈ S) => repCyclicSubspace pi x) x hx this
  have hclosed : IsClosed
      (((⨆ x ∈ S, repCyclicSubspace pi x).topologicalClosure).comap
        (pi g).toLinearMap : Set H) :=
    (Submodule.isClosed_topologicalClosure _).preimage (pi g).continuous
  exact Submodule.topologicalClosure_minimal _ hle hclosed hv
