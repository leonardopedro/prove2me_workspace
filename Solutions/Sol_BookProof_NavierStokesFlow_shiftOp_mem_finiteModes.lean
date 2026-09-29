-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.shiftOp_mem_finiteModes
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
theorem solution (m : ℤ) {f : L2Z} (hf : f ∈ finiteModes) :
    shiftOp m f ∈ finiteModes := by

  rw [mem_finiteModes] at hf ⊢
  refine Set.Finite.subset (hf.image fun k => k - m) ?_
  intro k hk
  simp only [Function.mem_support, shiftOp_apply] at hk
  exact ⟨k + m, hk, by ring⟩
