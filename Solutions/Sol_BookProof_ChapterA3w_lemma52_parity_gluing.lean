-- Generated from ChapterA3w.lean — solution of BookProof.ChapterA3w.lemma52_parity_gluing
import Mathlib
import Definitions.Def_ChapterA3w
open BookProof.ChapterA3w



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3q

set_option maxHeartbeats 1000000 in
theorem solution :
    (projChirL * mgamma 0 ≠ mgamma 0 * projChirL) ∧
    (projChirL * mgamma 0 = mgamma 0 * projChirR) ∧
    (parityDiag * projLL ≠ projLL * parityDiag) ∧
    (parityDiag * projRR = projLL * parityDiag) :=
  ⟨chirality_not_parity_invariant, parity_swaps_chirL,
     projLL_not_parity_invariant, parity_swaps_LL_RR⟩
