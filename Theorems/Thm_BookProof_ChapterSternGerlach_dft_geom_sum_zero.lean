-- Generated from ChapterSternGerlach.lean — theorem BookProof.ChapterSternGerlach.dft_geom_sum_zero
import Mathlib
import Definitions.Def_ChapterSternGerlach
open BookProof.ChapterSternGerlach



open Complex Matrix Finset

theorem BookProof.ChapterSternGerlach.dft_geom_sum_zero (n : ℕ) (w : ℂ) (hw : w ≠ 1) (hwn : w ^ n = 1) :
    ∑ i ∈ Finset.range n, w ^ i = 0 := by sorry
