-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.velocityOp_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_mem_finiteModes
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}









open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution (v : LinfZ) {f : L2Z} (hf : f ∈ finiteModes) :
    velocityOp v f ∈ finiteModes := by

  rw [mem_finiteModes] at hf ⊢
  refine hf.subset fun k hk => ?_
  simp only [Function.mem_support, velocityOp_apply] at hk
  exact fun hzero => hk (by rw [hzero, mul_zero])
