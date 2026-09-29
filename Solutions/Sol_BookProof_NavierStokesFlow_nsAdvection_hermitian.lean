-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsAdvection_hermitian
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) : (nsAdvection d i)ᴴ = nsAdvection d i := by

  simp only [nsAdvection, Matrix.conjTranspose_sub, Matrix.conjTranspose_smul,
    Matrix.conjTranspose_sum, Matrix.conjTranspose_mul, nsVelocity, nsGradVelocity,
    nsLapVelocity, d.u_herm, Complex.star_def, Complex.conj_ofReal]
  congr 1
  exact Finset.sum_congr rfl fun j _ => d.u_comm _ _
