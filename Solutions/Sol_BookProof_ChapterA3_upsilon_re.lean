-- Generated from ChapterA4c.lean — solution of BookProof.ChapterA3.upsilon_re
import Mathlib
import Definitions.Def_ChapterA4c
import Theorems.Thm_BookProof_ChapterA3_upsilonC_real
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) (μ ν : Fin 4) :
    ((Upsilon T μ ν : ℝ) : ℂ) = UpsilonC T μ ν := by

  unfold Upsilon
  simp only [Matrix.of_apply]
  exact (Complex.conj_eq_iff_re.mp (upsilonC_real T μ ν)) ▸ rfl
