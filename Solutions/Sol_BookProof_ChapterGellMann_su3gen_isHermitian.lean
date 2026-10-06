-- Generated from ChapterGellMann.lean — solution of BookProof.ChapterGellMann.su3gen_isHermitian
import Mathlib
import Definitions.Def_ChapterGellMann
import Theorems.Thm_BookProof_ChapterGellMann_gellMann_isHermitian
open BookProof.ChapterGellMann



open Matrix


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 8) : (su3gen a).IsHermitian := by

  rw [Matrix.IsHermitian, su3gen, Matrix.conjTranspose_smul, (gellMann_isHermitian a)]
  norm_num
