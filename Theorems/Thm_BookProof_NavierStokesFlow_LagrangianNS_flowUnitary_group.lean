-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.LagrangianNS.flowUnitary_group
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

flowUnitary t)ᴴ * L.flowUnitary t = 1 := by
  have h := BookProof.ChapterContinuityUnitary.exp_smul_I_unitary L.hFull
    L.transformed_hamiltonian_hermitian t
  rwa [flowUni := by sorry
