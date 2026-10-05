-- Generated from ChapterA3m.lean — solution of BookProof.ChapterA3m.swap23_spinGenDiag_comm
import Mathlib
import Definitions.Def_ChapterA3m
import Theorems.Thm_BookProof_ChapterA3m_swap23_kronecker
open BookProof.ChapterA3m



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

set_option maxHeartbeats 1000000 in
theorem solution (μ ν : Fin 4) :
    swap23 * spinGenDiag3 μ ν = spinGenDiag3 μ ν * swap23 := by

  unfold spinGenDiag3;
  simp only [mul_add];
  rw [ swap23_kronecker, swap23_kronecker, swap23_kronecker ];
  rw [ add_mul, add_mul ] ; abel_nf;
