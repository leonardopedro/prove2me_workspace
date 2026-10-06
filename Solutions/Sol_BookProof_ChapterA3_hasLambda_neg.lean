-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.hasLambda_neg
import Mathlib
import Definitions.Def_ChapterA3c
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution {S Λ : Matrix (Fin 4) (Fin 4) ℝ} (h : HasLambda S Λ) :
    HasLambda (-S) Λ := by

  intro μ; specialize h μ; simp_all only [inv_def, Ring.inverse_eq_inv', Algebra.smul_mul_assoc,
      mul_neg] ;
  simp_all only [det_neg, Fintype.card_fin, _root_.mul_inv_rev];
  convert h using 1;
  rw [ show ( -S ).adjugate = ( -1 ) ^ 3 • S.adjugate from ?_ ] ; focus (norm_num [ pow_succ ]);
  convert Matrix.adjugate_smul ( -1 : ℝ ) S using 1 ; focus (norm_num);
  norm_num [ Fintype.card_fin ]
