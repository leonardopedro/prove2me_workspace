-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.repInvariant_orthogonal
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
theorem solution {M : Submodule ℂ H} (hM : RepInvariant pi M) :
    RepInvariant pi Mᗮ := by

  intro g v hv
  rw [Submodule.mem_orthogonal]
  intro u hu
  have hadj : (ContinuousLinearMap.adjoint (pi g)) u = pi (star g) u := by
    have h : star (pi g) = pi (star g) := (map_star pi g).symm
    rw [← ContinuousLinearMap.star_eq_adjoint, h]
  have h0 : (inner ℂ (pi (star g) u) v : ℂ) = 0 :=
    (Submodule.mem_orthogonal M v).1 hv _ (hM (star g) u hu)
  rw [← ContinuousLinearMap.adjoint_inner_left, hadj, h0]
