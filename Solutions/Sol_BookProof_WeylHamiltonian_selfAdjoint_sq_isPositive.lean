-- Generated from ChapterWeylHamiltonian.lean — solution of BookProof.WeylHamiltonian.selfAdjoint_sq_isPositive
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
open BookProof.WeylHamiltonian




open ContinuousLinearMap
open scoped BigOperators

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : H →L[ℂ] H) (h : IsSelfAdjoint T) :
    (T ∘L T).IsPositive := by

  have hh : adjoint T = T := h
  have hp := isPositive_adjoint_comp_self T
  rwa [hh] at hp
