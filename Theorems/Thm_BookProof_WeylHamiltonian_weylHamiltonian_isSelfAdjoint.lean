-- Generated from ChapterWeylHamiltonian.lean — theorem BookProof.WeylHamiltonian.weylHamiltonian_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
open BookProof.WeylHamiltonian

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open ContinuousLinearMap
open scoped BigOperators


hB : ∀ a, IsSelfAdjoint (B a)) (x : H) :
    0 ≤ RCLike.re (inner ℂ ((weylHamiltonian π B) x) x) :=
  (weylHamiltonian_isPositive π B hπ hB).2 x

theorem BookProof.WeylHamiltonian.weylHamiltonian_isSelfAdjoint {n m : ℕ}
    (π : Fin n → H →L[ := by sorry
