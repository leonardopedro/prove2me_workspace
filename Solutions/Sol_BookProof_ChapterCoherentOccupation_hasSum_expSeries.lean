-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.hasSum_expSeries
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) :
    HasSum (fun n : ℕ => lam ^ n / (n ! : ℝ)) (Real.exp lam) := by

  rw [Real.exp_eq_exp_ℝ, NormedSpace.exp_eq_tsum_div]
  exact (Real.summable_pow_div_factorial lam).hasSum
