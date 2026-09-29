-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.lc1_vanish'
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex










open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

















variable {u : (Fin d →₀ ℕ) → ℂ}


























variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}

theorem BookProof.CarlemanSimplex.lc1_vanish' (i : Fin d) (a : Fin d →₀ ℕ) (h : ¬ Finsupp.single i 1 ≤ a) :
    lc1 a i = 0 := by sorry
