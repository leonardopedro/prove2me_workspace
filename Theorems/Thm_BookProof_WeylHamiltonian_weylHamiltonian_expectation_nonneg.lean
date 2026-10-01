-- Generated from ChapterWeylHamiltonian.lean — theorem BookProof.WeylHamiltonian.weylHamiltonian_expectation_nonneg
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
open BookProof.WeylHamiltonian

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open ContinuousLinearMap
open scoped BigOperators


 i))
  · refine smul_nonneg_isPositive _ ?_ (by norm_num)
    exact ContinuousLinearMap.isPositive_sum _ (fun a _ => selfAdjoint_sq_isPositive _ (hB a))

theorem BookProof.WeylHamiltonian.weylHamiltonian_expectation_nonneg {n m : ℕ}
    (π : Fin n → H →L[ℂ] H) (B : Fin m → H → := by sorry
