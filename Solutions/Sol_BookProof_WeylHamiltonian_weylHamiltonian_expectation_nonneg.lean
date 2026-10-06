-- Generated from ChapterWeylHamiltonian.lean — solution of BookProof.WeylHamiltonian.weylHamiltonian_expectation_nonneg
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
import Theorems.Thm_BookProof_WeylHamiltonian_weylHamiltonian_isPositive
open BookProof.WeylHamiltonian




open ContinuousLinearMap
open scoped BigOperators

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {n m : ℕ}
    (π : Fin n → H →L[ℂ] H) (B : Fin m → H →L[ℂ] H)
    (hπ : ∀ i, IsSelfAdjoint (π i)) (hB : ∀ a, IsSelfAdjoint (B a)) (x : H) :
    0 ≤ RCLike.re (inner ℂ ((weylHamiltonian π B) x) x) :=
  L[ℂ] H)
      (hπ : ∀ i, IsSelfAdjoint (π i))
