-- Generated from ChapterA4f.lean — solution of BookProof.ChapterA4f.boostZ_preserves_angle
import Mathlib
import Definitions.Def_ChapterA4f
open BookProof.ChapterA4f



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution {l : ℂ} (hl : l ≠ 0) (T : Matrix (Fin 2) (Fin 2) ℂ) :
    (boostZ l * T * boostZ l⁻¹) 0 0 = T 0 0 := by

      unfold boostZ; simp only [cons_mul, Nat.succ_eq_add_one, Nat.reduceAdd, empty_mul,
          Equiv.symm_apply_apply, inv_inv, Fin.isValue, mul_apply, of_apply, cons_val',
              cons_val_fin_one, cons_val_zero, Fin.sum_univ_two, cons_val_one, mul_zero, add_zero] ;
      simp only [vecMul, Fin.isValue, cons_dotProduct, head_val', tail_val', zero_mul,
          dotProduct_of_isEmpty, add_zero];
      exact mul_div_cancel_left₀ _ hl
