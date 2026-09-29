-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsFlow_unitary
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_NavierStokesFlow_nsHamiltonian_hermitian
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : (nsFlowUnitary d t)ᴴ * nsFlowUnitary d t = 1 := BookProof.ChapterContinuityUnitary.exp_smul_I_unitary _ (nsHamiltonian_hermitian d) t
