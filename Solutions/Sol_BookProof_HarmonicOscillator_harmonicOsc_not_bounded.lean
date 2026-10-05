-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.harmonicOsc_not_bounded
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_not_bounded
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ f : hermiteCore, ‖harmonicOscOp f‖ ≤ C * ‖(f : L2R)‖ := by

  refine hermiteCoreOp_not_bounded harmonicSymbol fun C => ?_
  obtain ⟨n, hn⟩ := exists_nat_gt C
  refine ⟨n, ?_⟩
  have h : |harmonicSymbol n| = (n : ℝ) + 1 / 2 := by
    rw [harmonicSymbol, abs_of_nonneg (by positivity)]
  rw [h]
  linarith
