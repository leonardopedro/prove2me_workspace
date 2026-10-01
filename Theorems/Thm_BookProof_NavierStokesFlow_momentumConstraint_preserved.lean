-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.momentumConstraint_preserved
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterFreeFieldConstraint
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FreeFieldConstraint
open BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.momentumConstraint_preserved {n : ℕ} (D H A : Matrix (Fin n) (Fin n) ℂ)
    (hDH : BookProof.FreeFieldConstraint.bracket D H = 0)
    (hDA : BookProof.FreeFieldConstraint.bracket D A = 0) :
    BookProof.FreeFieldConstraint.bracket D (BookProof.FreeFieldConstraint.bracket H A) = 0 := by sorry
