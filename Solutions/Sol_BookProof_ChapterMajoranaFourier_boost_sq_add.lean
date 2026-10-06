-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.boost_sq_add
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (m q : ℝ) (hm : 0 ≤ m) (hq : 0 < q) :
    boostC m q ^ 2 + boostS m q ^ 2 = 1 := by

      rw [ boostC, boostS, Real.sq_sqrt, Real.sq_sqrt ];
      · rw [ ← add_div, div_eq_iff ] <;> ring ; norm_num [ Ep, hm, hq ];
        positivity;
      · exact div_nonneg ( sub_nonneg.2 <| Real.le_sqrt_of_sq_le <|
          by nlinarith ) <| mul_nonneg zero_le_two <| Real.sqrt_nonneg _;
      · exact div_nonneg ( add_nonneg ( Real.sqrt_nonneg _ ) hm ) ( mul_nonneg zero_le_two (
          Real.sqrt_nonneg _ ) )
