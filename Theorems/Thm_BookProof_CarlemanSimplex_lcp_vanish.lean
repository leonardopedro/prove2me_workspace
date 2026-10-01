-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.lcp_vanish
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

theorem BookProof.CarlemanSimplex.lcp_vanish (i j : Fin d) (a : Fin d →₀ ℕ) (h : ¬ pvec i j ≤ a) : lcp a i j = 0 := by sorry
