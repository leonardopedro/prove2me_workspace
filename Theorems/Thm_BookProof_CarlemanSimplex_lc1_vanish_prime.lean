-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.lc1_vanish'
import Mathlib
import Definitions.Def_ChapterCarlemanSimplexPromoted
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterCarlemanTwoStepPromoted

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.CarlemanTwoStep

noncomputable section


theorem BookProof.CarlemanSimplex.lc1_vanish_prime (i : Fin d) (a : Fin d →₀ ℕ) (h : ¬ Finsupp.single i 1 ≤ a) :
    lc1 a i = 0 := by sorry
