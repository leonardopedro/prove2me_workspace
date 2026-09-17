-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsHamiltonian_hermitian
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_NavierStokesFlow_nsAdvection_hermitian
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution : (nsHamiltonian d)ᴴ = nsHamiltonian d := by

  simp only [nsHamiltonian, Matrix.conjTranspose_sum, Matrix.conjTranspose_add,
    Matrix.conjTranspose_mul, nsAdvection_hermitian, d.mom_herm]
  exact Finset.sum_congr rfl fun i _ => add_comm _ _
