-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.projChirL_parity_commutator
import Mathlib
import Definitions.Def_ChapterA3j
import Theorems.Thm_BookProof_ChapterA3j_parity_swaps_chirL
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    projChirL * mgamma 0 - mgamma 0 * projChirL
      = Complex.I • (mgamma 0 * chir) := by

  convert congr_arg (fun x => x - mgamma 0 * projChirL) parity_swaps_chirL using 1
  unfold projChirL projChirR
  norm_num [mul_add, mul_sub, ← smul_assoc]
  ext i j; norm_num; ring
