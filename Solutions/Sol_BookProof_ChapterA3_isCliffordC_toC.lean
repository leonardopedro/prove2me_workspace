-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.isCliffordC_toC
import Mathlib
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution {A : Fin 4 → Matrix (Fin 4) (Fin 4) ℝ} (hA : IsCliffordR A) :
    IsCliffordC (fun μ => toC (A μ)) := by

  intro μ ν; specialize hA μ ν; simp_all only [neg_mul, neg_smul, ← ext_iff,
      Matrix.add_apply, Matrix.mul_apply] ;
  convert hA using 3;
  simp [ ← Complex.ofReal_inj, minkowski, minkowskiR, toC ];
  simp [ Matrix.one_apply ];
  split_ifs <;> norm_num
