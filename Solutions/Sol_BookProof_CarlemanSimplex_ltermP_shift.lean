-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.ltermP_shift
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {w : ℂ} {rc lc : (Fin d →₀ ℕ) → ℝ} {P : Fin d →₀ ℕ}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + P) = rc a) (b : Fin d →₀ ℕ) :
    ltermP u w lc P (b + P) = (starRingEnd ℂ) (rtermP u w rc P b) := by

  rw [ltermP, rtermP, hcomp b, add_tsub_cancel_right]
  simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal]
  ring
