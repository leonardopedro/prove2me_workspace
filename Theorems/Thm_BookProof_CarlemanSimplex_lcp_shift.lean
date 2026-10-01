-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.lcp_shift
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

theorem BookProof.CarlemanSimplex.lcp_shift (i j : Fin d) (a : Fin d →₀ ℕ) :
    lcp (a + pvec i j) i j = rcp a i j := by sorry
