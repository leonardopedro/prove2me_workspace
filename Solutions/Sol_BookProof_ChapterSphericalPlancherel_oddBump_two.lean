-- Generated from ChapterSphericalPlancherel.lean — solution of BookProof.ChapterSphericalPlancherel.oddBump_two
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel




open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution : oddBump 2 = 1 := by

  have h1 : bumpAtTwo (2 : ℝ) = 1 := bumpAtTwo.one_of_mem_closedBall (by simp [bumpAtTwo])
  have h2 : bumpAtTwo (-2 : ℝ) = 0 := by
    apply ContDiffBump.zero_of_le_dist
    simp [bumpAtTwo, Real.dist_eq]
    norm_num
  simp [oddBump, h1, h2]
