-- Generated from ChapterA3k.lean — solution of BookProof.ChapterA3k.projLL_ne_projRR
import Mathlib
import Definitions.Def_ChapterA3k
open BookProof.ChapterA3k



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution : projLL ≠ projRR := by

  intro h
  have hentry := congr_fun (congr_fun h (0, 0)) (0, 1)
  unfold projLL projRR at hentry
  norm_num [projChirL, projChirR, chir, mgamma5, mgamma, mgammaZ] at hentry
  norm_num [Complex.ext_iff, mgamma5Z] at hentry
