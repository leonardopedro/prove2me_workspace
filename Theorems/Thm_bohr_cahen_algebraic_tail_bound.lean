import Mathlib
import Definitions.Def_timepiece_corrector
open Complex Finset Filter Topology
open scoped ArithmeticFunction ArithmeticFunction.Moebius ComplexConjugate

theorem bohr_cahen_algebraic_tail_bound (P : ℕ) (s s₀ : ℂ) (hs : s.re > s₀.re)
    (M_P : ℝ) (hM_nonneg : 0 ≤ M_P) :
    ∀ (ω : Ω_infty), (∀ N, ‖S_recip_random N P s₀ ω‖ ≤ M_P) →
    ∀ m N, 0 < m → m ≤ N →
      ‖∑ n ∈ Icc m N, ((μ n : ℂ) * X_mult n P ω) / (n ^ s)‖ ≤
      (M_P * (2 + ‖s - s₀‖ + ‖s - s₀‖ / (s.re - s₀.re))) *
        (m : ℝ) ^ (s₀.re - s.re) := by sorry
