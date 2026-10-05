-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.toC_Upsilon
import Mathlib
import Definitions.Def_ChapterA3h
import Theorems.Thm_BookProof_ChapterA3_upsilonC_real
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) :
    toC (Upsilon T) = UpsilonC T := by

  ext μ ν; simp only [toC, map_apply] ;
  exact Complex.conj_eq_iff_re.mp ( upsilonC_real T μ ν ) ▸ rfl
