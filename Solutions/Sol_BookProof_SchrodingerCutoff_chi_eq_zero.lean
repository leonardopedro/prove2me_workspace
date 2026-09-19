-- Generated from ChapterSchrodingerCutoffEsa.lean — solution of BookProof.SchrodingerCutoff.chi_eq_zero
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
open BookProof.SchrodingerCutoff




open MeasureTheory Filter Complex

set_option maxHeartbeats 1000000 in
theorem solution {y : ℝ} (hy : 2 ≤ |y|) : chi y = 0 := bump0.zero_of_le_dist (by simpa [Real.dist_eq, bump0] using hy)
