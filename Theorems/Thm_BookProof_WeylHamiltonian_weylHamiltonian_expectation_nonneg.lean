-- Generated from ChapterWeylHamiltonian.lean — theorem BookProof.WeylHamiltonian.weylHamiltonian_expectation_nonneg
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
open BookProof.WeylHamiltonian



open ContinuousLinearMap
open scoped BigOperators

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


theorem BookProof.WeylHamiltonian.weylHamiltonian_expectation_nonneg {n m : ℕ}
    (π : Fin n → H →L[ℂ] H) (B : Fin m → H →L[ℂ] H)
    (hπ : ∀ i, IsSelfAdjoint (π i)) (hB : ∀ a, IsSelfAdjoint (B a)) (x : H) :
    0 ≤ RCLike.re (inner ℂ ((weylHamiltonian π B) x) x) := by sorry
