-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.LagrangianNS.transformed_hamiltonian_hermitian
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianNS_kinetic_posSemidef
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianNS_viscous_posSemidef
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution : (L.hFull)ᴴ = L.hFull := by

  have hk : (L.kinetic)ᴴ = L.kinetic := (kinetic_posSemidef L).isHermitian
  have hv : (L.viscous)ᴴ = L.viscous := (viscous_posSemidef L).isHermitian
  have hd : (L.drift)ᴴ = L.drift := by
    simp only [drift, Matrix.conjTranspose_sum, Matrix.conjTranspose_smul, L.D_herm,
      star_trivial]
  simp only [hFull, Matrix.conjTranspose_add, hk, hv, hd, L.C_herm]
