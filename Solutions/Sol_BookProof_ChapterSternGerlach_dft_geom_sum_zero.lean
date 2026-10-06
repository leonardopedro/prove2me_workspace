-- Generated from ChapterSternGerlach.lean — solution of BookProof.ChapterSternGerlach.dft_geom_sum_zero
import Mathlib
import Definitions.Def_ChapterSternGerlach
open BookProof.ChapterSternGerlach




open Complex Matrix Finset

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (w : ℂ) (hw : w ≠ 1) (hwn : w ^ n = 1) :
    ∑ i ∈ Finset.range n, w ^ i = 0 := by

  rw [geom_sum_eq hw, hwn]; simp
