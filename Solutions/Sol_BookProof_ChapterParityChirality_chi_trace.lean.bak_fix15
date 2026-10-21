-- Generated from ChapterParityChirality.lean — solution of BookProof.ChapterParityChirality.chi_trace
import Mathlib
import Definitions.Def_ChapterParityChirality
open BookProof.ChapterParityChirality



open Matrix
open scoped Kronecker


open BookProof.ChapterA3
open BookProof.ChapterParity
open BookProof.ChapterParitySU2

set_option maxHeartbeats 1000000 in
theorem solution : chi.trace = 0 := by

  unfold chi;
  unfold mgamma5;
  unfold mgamma5Z pauli3; norm_num [ Fin.sum_univ_succ, Matrix.trace ] ;
  erw [ Finset.sum_product ] ; norm_num [ Fin.sum_univ_succ ]
