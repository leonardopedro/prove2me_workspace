-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsHamiltonian_hasZeroDeficiency
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_NavierStokesFlow_nsHamiltonian_hermitian
import Theorems.Thm_BookProof_NavierStokesFlow_symmetric_hasZeroDeficiency
open BookProof.NavierStokesFlow













open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct




variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]















variable {n : ℕ} (L : LagrangianNS n)

















variable {n : ℕ} (d : NSTruncation n)

































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution :
    HasZeroDeficiency (Matrix.toEuclideanLin (nsHamiltonian d)) :=
  symmetric_hasZeroDeficiency _
      (Matrix.isHermitian_iff_isSymmetric.mp (nsHamiltonian_hermitian d))
