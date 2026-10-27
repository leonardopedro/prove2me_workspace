-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.repInvariant_repCyclicSubspace
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

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))

set_option maxHeartbeats 1000000 in
omit [CompactSpace X] [T2Space X] [MeasurableSpace X] [BorelSpace X] in
theorem solution (xi : H) :
    RepInvariant pi (repCyclicSubspace pi xi) := by

  intro g v hv
  have hle : Submodule.span ℂ (Set.range fun f : C(X, ℂ) => pi f xi)
      ≤ (repCyclicSubspace pi xi).comap (pi g).toLinearMap := by
    refine Submodule.span_le.mpr ?_
    rintro _ ⟨f, rfl⟩
    have hgf : pi g (pi f xi) = pi (g * f) xi := by
      rw [map_mul]
      rfl
    simp only [SetLike.mem_coe, Submodule.mem_comap, ContinuousLinearMap.coe_coe, hgf]
    exact rep_apply_mem_repCyclicSubspace pi xi (g * f)
  have hclosed : IsClosed
      ((repCyclicSubspace pi xi).comap (pi g).toLinearMap : Set H) :=
    (isClosed_repCyclicSubspace pi xi).preimage (pi g).continuous
  exact Submodule.topologicalClosure_minimal _ hle hclosed hv
