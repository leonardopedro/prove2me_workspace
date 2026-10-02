-- Generated from ChapterStoneEvolution.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.norm_approxU_apply
import Mathlib
import Definitions.Def_ChapterStoneEvolution
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_approxU_mem_unitary
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (n t : ℝ) (x : H) : ‖T.approxU n t x‖ = ‖x‖ := by

  have hu : (star (T.approxU n t)) * T.approxU n t = 1 :=
    (Unitary.mem_iff.mp (T.approxU_mem_unitary n t)).1
  have hadj : ContinuousLinearMap.adjoint (T.approxU n t) (T.approxU n t x) = x := by
    have := congrArg (fun (S : H →L[ℂ] H) => S x) hu
    simpa [ContinuousLinearMap.star_eq_adjoint] using this
  have hinner : ⟪T.approxU n t x, T.approxU n t x⟫_ℂ = ⟪x, x⟫_ℂ := by
    rw [← ContinuousLinearMap.adjoint_inner_left, hadj]
  have h3 : (⟪T.approxU n t x, T.approxU n t x⟫_ℂ).re = (⟪x, x⟫_ℂ).re := by rw [hinner]
  simpa [inner_self_eq_norm_sq, ← Complex.ofReal_pow] using h3
