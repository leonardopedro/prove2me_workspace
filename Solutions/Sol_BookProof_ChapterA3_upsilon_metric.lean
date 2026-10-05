-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.upsilon_metric
import Mathlib
import Definitions.Def_ChapterA3h
import Theorems.Thm_BookProof_ChapterA3_toC_Upsilon
import Theorems.Thm_BookProof_ChapterA3_upsilonC_metric
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1) :
    (Upsilon T)ᵀ * minkowskiMat * Upsilon T = minkowskiMat := by

  -- Apply the complex identity `upsilonC_metric` to conclude the proof.
  have := upsilonC_metric T hT;
  simp_all only [← ext_iff];
  convert this using 1;
  simp [ ← toC_Upsilon, Matrix.mul_apply ];
  simp [ toC ];
  norm_cast
