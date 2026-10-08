-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.exists_mul_lt_of_not_summable_inv
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop



open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

theorem BookProof.CarlemanUnboundedHop.exists_mul_lt_of_not_summable_inv {A S : ℕ → ℝ} (hA : ∀ n, 0 < A n)
    (hSsum : Summable S) (hcar : ¬ Summable fun n => (A n)⁻¹) :
    ∀ ε > 0, ∀ N₀ : ℕ, ∃ N, N₀ ≤ N ∧ A N * S N < ε := by sorry
