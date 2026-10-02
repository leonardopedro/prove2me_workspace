-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsDivergenceConstraint_resolution
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution (u11 u22 u33 : ℝ) (h : u33 = -(u11 + u22)) :
    u11 + u22 + u33 = 0 := by

  rw [h]; ring
