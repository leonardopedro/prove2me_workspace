-- Generated from ChapterSphericalBesselODE.lean — solution of BookProof.ChapterSphericalBesselODE.contDiffOn_sbesselBase
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
open BookProof.ChapterSphericalBesselODE




open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution : ContDiffOn ℝ (⊤ : ℕ∞) sbesselBase {r : ℝ | r ≠ 0} := by

  apply ContDiffOn.div Real.contDiff_sin.contDiffOn contDiff_id.contDiffOn
  intro x hx; exact hx
