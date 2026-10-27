-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.ltermG_shift
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep




open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {w : ℂ} {rc lc : (Fin d →₀ ℕ) → Fin d → ℝ} {k : ℕ} {i : Fin d}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + Finsupp.single i k) i = rc a i) (b : Fin d →₀ ℕ) :
    ltermG u w lc k i (b + Finsupp.single i k) = (starRingEnd ℂ) (rtermG u w rc k i b) := by

  rw [ltermG, rtermG, hcomp b, add_tsub_cancel_right]
  simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal]
  ring
