-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.flux_identity
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
open BookProof.CarlemanUnboundedHop



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.flux_identity {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {z : ℂ} (hherm : IsHermitianKernel a)
    (hrec : LadderRecInf a u z) (N : ℕ) :
    z.im * ∑ n ∈ range (N + 1), ‖u n‖ ^ 2 = (flux a u N).im := by sorry
