-- Generated from ChapterProbabilityClockStochastic.lean — solution of BookProof.ProbabilityClockStochastic.Mab_isColumnStochastic
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
open BookProof.ProbabilityClockStochastic




open Matrix
open scoped Norms.Operator

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) : IsColumnStochastic (Mab a b) := by

  refine ⟨?_, ?_⟩
  · intro i j; fin_cases i <;> fin_cases j <;> simp only [Mab, Fin.zero_eta, Fin.isValue, of_apply,
      cons_val', cons_val_zero, cons_val_fin_one, Fin.mk_one, cons_val_one] <;> positivity
  · intro j; fin_cases j <;>
      simp [Mab, Fin.sum_univ_two, Real.cos_sq_add_sin_sq]
