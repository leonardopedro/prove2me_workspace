-- Generated from ChapterSchrodingerCutoffEsa.lean — solution of BookProof.SchrodingerCutoff.chi_eq_one_of_abs_le_one
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
open BookProof.SchrodingerCutoff




open MeasureTheory Filter Complex

set_option maxHeartbeats 1000000 in
theorem solution {x : ℝ} (hx : |x| ≤ 1) : chi x = 1 := bump0.one_of_mem_closedBall (by simpa [Real.dist_eq, bump0] using hx)
