-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.eq_zero_of_flux_small
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.eq_zero_of_flux_small {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {z : ℂ} (hz : z.im ≠ 0)
    (hherm : IsHermitianKernel a) (hrec : LadderRecInf a u z)
    (hsmall : ∀ ε > 0, ∀ N₀ : ℕ, ∃ N, N₀ ≤ N ∧ ‖flux a u N‖ < ε) :
    ∀ n, u n = 0 := by sorry
