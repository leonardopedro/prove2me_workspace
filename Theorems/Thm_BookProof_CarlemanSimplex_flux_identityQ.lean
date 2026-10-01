-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.flux_identityQ
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.flux_identityQ (hM : ∀ i j, M j i = (starRingEnd ℂ) (M i j))
    (hrec : LadderRecQ u lam w W M z) (N : ℕ) :
    z.im * (∑ a ∈ simplexF d N, ‖u a‖ ^ 2)
      = (∑ i, (∑ a ∈ sBd d N 1, rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a).im)
        + ∑ i, ∑ j,
            (∑ a ∈ sBd d N 2, rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a).im := by sorry
