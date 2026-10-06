-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.diagFullData_hamiltonian
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_add
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_sub
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_real_smul
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_sum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable (d : NSFullData F)

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin 15 → ℕ → ℝ) (p : Fin 3 → ℕ → ℝ) (nu : ℝ) :
    (diagFullData c p nu).hamiltonian = diagOp (diagFullSymbol c p nu) := by

  simp only [diagFullData]
  simp only [NSFullData.hamiltonian, NSFullData.advection, NSFullData.velocity,
    NSFullData.gradVelocity, NSFullData.lapVelocity]
  simp only [diagOp_comp, diagOp_sum, diagOp_real_smul, diagOp_sub, diagOp_add]
  congr 1
  funext n
  simp only [diagFullSymbol]
  refine Finset.sum_congr rfl fun i _ => ?_
  ring
