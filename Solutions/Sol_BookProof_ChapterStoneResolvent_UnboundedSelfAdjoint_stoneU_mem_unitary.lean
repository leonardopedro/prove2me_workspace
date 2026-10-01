-- Generated from ChapterStoneUnitary.lean — solution of BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.stoneU_mem_unitary
import Mathlib
import Definitions.Def_ChapterStoneUnitary
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_surjective
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint



open scoped InnerProductSpace
open Filter Topology NormedSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : T.stoneU t ∈ unitary (H →L[ℂ] H) := by

  have hiso : ∀ x y : H, ⟪T.stoneU t x, T.stoneU t y⟫_ℂ = ⟪x, y⟫_ℂ := by
    intro x y
    have hli : (LinearMap.mk (T.stoneU t).toLinearMap.toAddHom
        (T.stoneU t).toLinearMap.map_smul' : H →ₗ[ℂ] H) = (T.stoneU t : H →ₗ[ℂ] H) := rfl
    have : ∀ z : H, ‖(T.stoneU t : H →ₗ[ℂ] H) z‖ = ‖z‖ := fun z => T.norm_stoneU_apply t z
    exact (LinearIsometry.mk (T.stoneU t : H →ₗ[ℂ] H) this).inner_map_map x y
  have hstar : star (T.stoneU t) * T.stoneU t = 1 := by
    ext x
    have : ContinuousLinearMap.adjoint (T.stoneU t) (T.stoneU t x) = x := by
      refine ext_inner_right ℂ ?_
      intro y
      rw [ContinuousLinearMap.adjoint_inner_left, hiso]
    simpa [ContinuousLinearMap.star_eq_adjoint] using this
  refine Unitary.mem_iff.mpr ⟨hstar, ?_⟩
  -- surjectivity upgrades the left inverse to a two-sided inverse
  ext y
  obtain ⟨x, hx⟩ := T.stoneU_surjective t y
  have hxx : (star (T.stoneU t)) (T.stoneU t x) = x := by
    have h := congrArg (fun (S : H →L[ℂ] H) => S x) hstar
    simpa using h
  rw [← hx]
  simp only [ContinuousLinearMap.mul_apply, ContinuousLinearMap.one_apply, hxx]
