-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.boost_sq_sub
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Theorems.Thm_BookProof_ChapterMajoranaFourier_Ep_pos
import Theorems.Thm_BookProof_ChapterMajoranaFourier_Ep_ge
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (m q : ℝ) (hm : 0 ≤ m) (hq : 0 < q) :
    boostC m q ^ 2 - boostS m q ^ 2 = m / Ep m q := by

      have hE : 0 < Ep m q := Ep_pos m q hq
      have hE2 : 0 < 2 * Ep m q := by positivity
      have hc : 0 ≤ (Ep m q + m) / (2 * Ep m q) :=
        div_nonneg (add_nonneg (le_of_lt hE) hm) (le_of_lt hE2)
      have hs : 0 ≤ (Ep m q - m) / (2 * Ep m q) :=
        div_nonneg (sub_nonneg.mpr (Ep_ge m q hm)) (le_of_lt hE2)
      rw [boostC, boostS, Real.sq_sqrt hc, Real.sq_sqrt hs]
      field_simp
      ring
