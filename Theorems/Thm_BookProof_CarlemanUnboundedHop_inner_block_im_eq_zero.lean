-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.inner_block_im_eq_zero
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.inner_block_im_eq_zero (a : ℕ → ℕ → ℂ) (u : ℕ → ℂ) (hherm : IsHermitianKernel a)
    (N : ℕ) :
    (∑ n ∈ range (N + 1), (starRingEnd ℂ) (u n) *
        ∑ k ∈ range (N + 1), a n k * u k).im = 0 := by sorry
