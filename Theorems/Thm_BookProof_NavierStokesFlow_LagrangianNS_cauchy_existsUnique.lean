-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.LagrangianNS.cauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

theorem BookProof.NavierStokesFlow.LagrangianNS.cauchy_existsUnique (psi : Fin n → ℂ) :
    ∃! y : ℝ → Fin n → ℂ,
      y 0 = psi ∧ ∀ t, HasDerivAt y ((Complex.I • L.hFull) *ᵥ y t) t := by sorry
