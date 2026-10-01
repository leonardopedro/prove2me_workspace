-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.ltermP_shift
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.ltermP_shift {w : ℂ} {rc lc : (Fin d →₀ ℕ) → ℝ} {P : Fin d →₀ ℕ}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + P) = rc a) (b : Fin d →₀ ℕ) :
    ltermP u w lc P (b + P) = (starRingEnd ℂ) (rtermP u w rc P b) := by sorry
