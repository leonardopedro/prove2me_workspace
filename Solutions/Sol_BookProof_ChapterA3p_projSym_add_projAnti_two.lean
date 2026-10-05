-- Generated from ChapterA3p.lean — solution of BookProof.ChapterA3p.projSym_add_projAnti_two
import Mathlib
import Definitions.Def_ChapterA3p
open BookProof.ChapterA3p



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o

set_option maxHeartbeats 1000000 in
theorem solution :
    projSym 2 + projAnti 2 = 1 := by

  ext a b; simp only [projSym, Nat.factorial_two, Nat.cast_ofNat, projAnti, Matrix.add_apply,
      Matrix.smul_apply, smul_eq_mul] ;
  unfold permMat signC;
  rw [ Finset.sum_eq_multiset_sum, Finset.sum_eq_multiset_sum ] ; norm_cast;
  erw [ show ( Finset.univ.val : Multiset ( Equiv.Perm ( Fin 2 ) ) )
          = { Equiv.refl ( Fin 2 ), Equiv.swap 0 1 } by decide ] ; norm_num ; ring;
  exact if_congr ( by aesop ) rfl rfl
