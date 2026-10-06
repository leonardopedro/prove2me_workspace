-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.mgammaR_indep
import Mathlib
import Definitions.Def_ChapterA3c
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin 4 → ℝ) (h : ∑ ν, c ν • mgammaR ν = 0) :
    ∀ ν, c ν = 0 := by

  unfold mgammaR at h;
  simp_all [ Fin.sum_univ_four, Fin.forall_fin_succ ];
  unfold mgammaZ at h; simp_all [ ← Matrix.ext_iff, Fin.forall_fin_succ ] ;
  constructor <;> linarith
