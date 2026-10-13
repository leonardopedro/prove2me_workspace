-- Generated from ChapterSphericalBesselODE.lean — solution of BookProof.ChapterSphericalBesselODE.gIter_succ
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE




open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (l : ℕ) (r : ℝ) : gIter (l + 1) r = -(1 / r) * deriv (gIter l) r := by

  simp [gIter, Function.iterate_succ_apply', rayleighOp]
