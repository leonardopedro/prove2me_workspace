-- Generated from ChapterSphericalBesselODE.lean — solution of BookProof.ChapterSphericalBesselODE.diffAt_gIter
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_contDiffOn_gIter
open BookProof.ChapterSphericalBesselODE




open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (l : ℕ) {r : ℝ} (hr : r ≠ 0) : DifferentiableAt ℝ (gIter l) r := ((contDiffOn_gIter l).differentiableOn (by simp)).differentiableAt (isOpen_ne.mem_nhds hr)
