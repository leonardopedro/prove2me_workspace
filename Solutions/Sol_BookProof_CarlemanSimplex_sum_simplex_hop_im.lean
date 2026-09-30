-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.sum_simplex_hop_im
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanSimplex_sum_simplex_split
import Theorems.Thm_BookProof_CarlemanSimplex_sum_ltermP
open BookProof.CarlemanSimplex











open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

















variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {w : ℂ} {rc lc : (Fin d →₀ ℕ) → ℝ} {P : Fin d →₀ ℕ}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + P) = rc a)
    (hvan : ∀ a : Fin d →₀ ℕ, ¬ P ≤ a → lc a = 0) (N : ℕ) :
    (∑ a ∈ simplexF d N, (rtermP u w rc P a + ltermP u w lc P a)).im
      = (∑ a ∈ sBd d N (deg P), rtermP u w rc P a).im := by

  rw [Finset.sum_add_distrib, sum_simplex_split d N (deg P) (rtermP u w rc P),
    sum_ltermP hcomp hvan N]
  simp [Complex.add_im]
