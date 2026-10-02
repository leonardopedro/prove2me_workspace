-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.LagrangianNS.flowUnitary_group
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)

set_option maxHeartbeats 1000000 in
flowUnitary t)ᴴ * L.flowUnitary t = 1 := by
  have h := BookProof.ChapterContinuityUnitary.exp_smul_I_unitary L.hFull
    L.transformed_hamiltonian_hermitian t
  rwa [flowUni :=
  tary, matrixFlow, ← smul_assoc, Complex.real_smul]
  
  /-- The transformed flow is a one-parameter group: it is **complete**. -/
  theorem flowUnitary_group (s t : ℝ) :
      L.flowUnitary (s + t) = L.flowUnitary s * L.flowUnitary t := by
    have hcomm : Commute ((s : ℝ) • (Complex.I • L.hFull)) ((t : ℝ) •
