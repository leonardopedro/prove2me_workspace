-- Generated from ChapterA4f.lean — solution of BookProof.ChapterA4f.boostZ_scales_translation
import Mathlib
import Definitions.Def_ChapterA4f
open BookProof.ChapterA4f



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (l : ℂ) (T : Matrix (Fin 2) (Fin 2) ℂ) :
    (boostZ l * T * boostZ l⁻¹) 1 0 = (l⁻¹) ^ 2 * T 1 0 := by

      simp only [Fin.isValue, mul_apply, Fin.sum_univ_two, pow_two, mul_assoc];
      unfold boostZ; norm_num; ring;
