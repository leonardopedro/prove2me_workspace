-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsBrst_adjoint
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_GhostField_psiDag_eq_conjTranspose
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution : (nsBrstCharge d)ᴴ = nsDivergence d ⊗ₖ BookProof.GhostField.psi := by

  have hD : (nsDivergence d)ᴴ = nsDivergence d := by
    simp only [nsDivergence, Matrix.conjTranspose_sum, nsGradVelocity, d.u_herm]
  have hp : (BookProof.GhostField.psiDag)ᴴ = BookProof.GhostField.psi := by
    rw [BookProof.GhostField.psiDag_eq_conjTranspose, Matrix.conjTranspose_conjTranspose]
  rw [nsBrstCharge, Matrix.conjTranspose_kronecker, hD, hp]
