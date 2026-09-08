import Mathlib
import Definitions.Def_timepiece_corrector
import Theorems.Thm_norm_X_mult_list_eq_one
open Complex Finset Filter Topology
open scoped ArithmeticFunction ArithmeticFunction.Moebius ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (n P : ℕ) (ω : Ω_infty) : ‖X_mult n P ω‖ = 1 := by
  unfold X_mult
  exact norm_X_mult_list_eq_one P ω (Nat.primeFactorsList n)
