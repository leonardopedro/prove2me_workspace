-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.exists_mul_lt_of_not_summable_inv
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterA4

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.exists_mul_lt_of_not_summable_inv {A S : ℕ → ℝ} (hA : ∀ n, 0 < A n)
    (hSsum : Summable S) (hcar : ¬ Summable fun n => (A n)⁻¹) :
    ∀ ε > 0, ∀ N₀ : ℕ, ∃ N, N₀ ≤ N ∧ A N * S N < ε := by sorry
