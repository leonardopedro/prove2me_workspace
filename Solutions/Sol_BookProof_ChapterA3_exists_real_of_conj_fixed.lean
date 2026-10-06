-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.exists_real_of_conj_fixed
import Mathlib
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution {N : Matrix (Fin 4) (Fin 4) ℂ}
    (hN : N.map (starRingEnd ℂ) = N) : ∃ M : Matrix (Fin 4) (Fin 4) ℝ, toC M = N := by

  use Matrix.of (fun i j => (N i j).re);
  ext i j; simp only [toC, map_apply, Matrix.of_apply];
  replace hN := congr_fun ( congr_fun hN i ) j; simp_all [ Complex.ext_iff ] ;
  grobner
