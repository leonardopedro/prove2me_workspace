-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.isPin_neg
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_hasLambda_neg
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution {S : Matrix (Fin 4) (Fin 4) ℝ} (h : IsPin S) : IsPin (-S) := by

  refine ⟨ ?_, ?_, ?_ ⟩;
  · rw [ Matrix.det_neg ];
    exact IsUnit.mul ( isUnit_one.neg.pow _ ) h.1;
  · convert h.2.1 using 1;
    norm_num [ Matrix.det_neg ];
  · exact ⟨ _, hasLambda_neg ( h.2.2.choose_spec ) ⟩
