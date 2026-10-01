-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.LagrangianNS.cauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

Complex.I • L.hFull)) :=
    ((Commute.refl (Complex.I • L.hFull)).smul_left s).smul_right t
  rw [flowUnitary, flowUnitary, flowUnitary, matrixFlow, matrixFlow, matrixFlow, add_smul,
    Matrix.exp_add_of_commute _ _ hcomm]

/-- **B (truncated completeness)** *The Cauchy problem of the transformed
Lagrangian operator has exactly one g := by sorry
