-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsCauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsCauchy_existsUnique (psi : Fin n → ℂ) :
    ∃! y : ℝ → Fin n → ℂ,
      y 0 = psi ∧ ∀ t, HasDerivAt y ((Complex.I • nsHamiltonian d) *ᵥ y t) t := by sorry
