-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.velocityOp_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_mem_finiteModes
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (v : LinfZ) {f : L2Z} (hf : f ∈ finiteModes) :
    velocityOp v f ∈ finiteModes :=
   finite-mode
  domain. -/
  theorem velocityOp_mem_finiteModes (v : LinfZ) {f : L2Z} (hf : f ∈ finiteModes) :
      velocityOp v f ∈ finiteModes := by
    rw [mem_finiteModes] at hf ⊢
