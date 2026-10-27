-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.kinetic_nonneg
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_LagrangianFullData_kinetic_inner
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

set_option maxHeartbeats 1000000 in
theorem solution (v : L.D) : 0 ≤ (inner ℂ (v : F) (L.kinetic v : F) : ℂ).re := by

  rw [L.kinetic_inner v, Complex.ofReal_re]
  have : (0 : ℝ) ≤ ∑ i : Fin 3, ‖(L.P i v : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => sq_nonneg _
  linarith
