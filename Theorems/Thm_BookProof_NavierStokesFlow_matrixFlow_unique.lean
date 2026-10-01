-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_unique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

<;> (first
      | rfl
      | (change A *ᵥ (matrixFlow A t *ᵥ x) = (matrixFlow A t * A) *ᵥ x
          <;> rw [matrixFlow_comm, ← Matrix.mulVec_mulVec])
      | simp [applyVecCLM, matrixFlow_comm, Matrix.mulVec_mulVec])

/-- **Uniqueness for the linear Cauchy problem.**  Any differentiable curve with
`ẏ(t) = A y(t)` for every `t` and `y(0) = x` is the orbit of the flow.  The
proof is the classical one: `t ↦ e^{−tA} y(t)` has vanishing derivative, hence := by sorry
