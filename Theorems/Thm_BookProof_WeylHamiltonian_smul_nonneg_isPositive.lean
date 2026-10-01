-- Generated from ChapterWeylHamiltonian.lean — theorem BookProof.WeylHamiltonian.smul_nonneg_isPositive
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
open BookProof.WeylHamiltonian

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open ContinuousLinearMap
open scoped BigOperators

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.WeylHamiltonian.smul_nonneg_isPositive (T : H →L[ℂ] H) (h : T.IsPositive)
    {c : ℝ} (hc : 0 ≤ c) : ((c : ℂ) • T).IsPositive := by sorry
