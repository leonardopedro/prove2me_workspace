-- Generated from ChapterWeylHamiltonian.lean — theorem BookProof.WeylHamiltonian.selfAdjoint_sq_isPositive
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
open BookProof.WeylHamiltonian



open ContinuousLinearMap
open scoped BigOperators

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


theorem BookProof.WeylHamiltonian.selfAdjoint_sq_isPositive (T : H →L[ℂ] H) (h : IsSelfAdjoint T) :
    (T ∘L T).IsPositive := by sorry
