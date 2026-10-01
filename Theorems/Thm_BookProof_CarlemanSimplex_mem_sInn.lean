-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.mem_sInn
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

theorem BookProof.CarlemanSimplex.mem_sInn {d N k : ℕ} {a : Fin d →₀ ℕ} : a ∈ sInn d N k ↔ deg a + k ≤ N := by sorry
