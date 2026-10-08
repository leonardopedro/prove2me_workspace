-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.summable_normSq_lp
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow.LpNat
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (f : L2N) : Summable fun n : ℕ => ‖(f : ℕ → ℂ) n‖ ^ 2 := by

  have hsum := (lp.memℓp f).summable (p := 2) (by norm_num)
  refine hsum.congr fun n => ?_
  rw [show ENNReal.toReal 2 = ((2 : ℕ) : ℝ) by norm_num, Real.rpow_natCast]
