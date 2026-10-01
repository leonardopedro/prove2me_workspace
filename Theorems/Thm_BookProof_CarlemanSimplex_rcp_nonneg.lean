-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.rcp_nonneg
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

theorem BookProof.CarlemanSimplex.rcp_nonneg (a : Fin d →₀ ℕ) (i j : Fin d) : 0 ≤ rcp a i j := by sorry
