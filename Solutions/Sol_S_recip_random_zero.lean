import Mathlib
import Definitions.Def_timepiece_corrector
import Theorems.Thm_X_mult_zero
open Complex Finset Filter Topology
open scoped ArithmeticFunction ArithmeticFunction.Moebius ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (N P : ℕ) (s : ℂ) :
    S_recip_random N P s (fun _ ↦ 0) = S_classical N s := by
  unfold S_recip_random S_classical
  exact sum_congr rfl (fun n _ ↦ by rw [X_mult_zero, mul_one])
