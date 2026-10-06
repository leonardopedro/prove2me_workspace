-- Generated from ChapterWeylHamiltonian.lean — theorem BookProof.WeylHamiltonian.weylHamiltonian_isPositive
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
open BookProof.WeylHamiltonian

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open ContinuousLinearMap
open scoped BigOperators


theorem BookProof.WeylHamiltonian.weylHamiltonian_isPositive {n m : ℕ}
    (π : Fin n → H →L[ℂ] H) (B : Fin m → H →L[ℂ] H)
    (hπ : ∀ i, IsSelfAdjoint (π i)) (hB : ∀ a, IsSelfAdjoint (B a)) :
    (weylHamiltonian π B).IsPositive := by sorry
