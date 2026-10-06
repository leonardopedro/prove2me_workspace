-- Generated from ChapterSphericalPlancherel.lean — solution of BookProof.ChapterSphericalPlancherel.oddSchwartz_ne_zero
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
import Theorems.Thm_BookProof_ChapterSphericalPlancherel_oddBump_two
import Theorems.Thm_BookProof_ChapterSphericalPlancherel_oddSchwartz_apply
open BookProof.ChapterSphericalPlancherel




open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution : oddSchwartz ≠ 0 := by

  intro h
  have h2 : oddSchwartz 2 = 0 := by rw [h]; rfl
  rw [oddSchwartz_apply, oddBump_two] at h2
  exact one_ne_zero h2
