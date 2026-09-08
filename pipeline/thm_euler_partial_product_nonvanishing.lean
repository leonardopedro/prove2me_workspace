import Mathlib
import Definitions.Def_timepiece_corrector
open Complex Finset Filter Topology
open scoped ArithmeticFunction ArithmeticFunction.Moebius ComplexConjugate

theorem euler_partial_product_nonvanishing (c : ℂ) (r : ℝ) (hr : 0 < r)
    (hball : ∀ z ∈ Metric.ball c r, z.re > 1 / 2)
    (P : ℕ) (ω : Ω_infty) (K : ℕ) :
    let g : ℂ → ℂ := fun s => ∏ p ∈ (Finset.Icc 2 K).filter Nat.Prime,
      (1 - X_p p P ω / (p : ℂ) ^ s)
    AnalyticOnNhd ℂ g (Metric.ball c r) ∧
    ∀ z ∈ Metric.ball c r, g z ≠ 0 := by sorry
