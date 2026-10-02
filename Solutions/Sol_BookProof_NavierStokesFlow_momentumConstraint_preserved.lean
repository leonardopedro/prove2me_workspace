-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.momentumConstraint_preserved
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_FreeFieldConstraint_constraint_preserved_under_bracket
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (D H A : Matrix (Fin n) (Fin n) ℂ)
    (hDH : BookProof.FreeFieldConstraint.bracket D H = 0)
    (hDA : BookProof.FreeFieldConstraint.bracket D A = 0) :
    BookProof.FreeFieldConstraint.bracket D (BookProof.FreeFieldConstraint.bracket H A) = 0 := BookProof.FreeFieldConstraint.constraint_preserved_under_bracket D H A hDH hDA
