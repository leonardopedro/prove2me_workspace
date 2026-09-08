import Mathlib

open Complex Finset
open scoped ArithmeticFunction ArithmeticFunction.Moebius

/-- The sequence space of continuous phases, used as the parameter space of the
multiplicative corrector. -/
abbrev Ω_infty := ℕ → ℝ

/-- Prime Perturbations: the corrector factor is fixed to 1 for primes p ≤ P
and rotates continuously on the unit circle for p > P. -/
noncomputable def X_p (p P : ℕ) (ω : Ω_infty) : ℂ :=
  if p ≤ P then 1 else Complex.exp (((2 * Real.pi * ω p : ℝ) : ℂ) * I)

/-- Multiplicative Extension: the corrector of n is the product of the
corrector factors of its prime divisors. -/
noncomputable def X_mult (n P : ℕ) (ω : Ω_infty) : ℂ :=
  ((Nat.primeFactorsList n).map (fun p ↦ X_p p P ω)).prod

/-- The classical deterministic partial Dirichlet series (recovered identically
when the phase path is identically zero). -/
noncomputable def S_classical (N : ℕ) (s : ℂ) : ℂ :=
  ∑ n ∈ Icc 1 N, (μ n : ℂ) / (n ^ s)

/-- The randomized reciprocal-zeta partial series with phase path ω. -/
noncomputable def S_recip_random (N P : ℕ) (s : ℂ) (ω : Ω_infty) : ℂ :=
  ∑ n ∈ Icc 1 N, ((μ n : ℂ) * X_mult n P ω) / (n ^ s)
