-- Generated from ChapterA3k.lean — solution of BookProof.ChapterA3k.projLL_not_parity_invariant
import Mathlib
import Definitions.Def_ChapterA3k
import Theorems.Thm_BookProof_ChapterA3k_parity_swaps_RR_LL
import Theorems.Thm_BookProof_ChapterA3k_parityDiag_sq
import Theorems.Thm_BookProof_ChapterA3k_projLL_ne_projRR
open BookProof.ChapterA3k



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution :
    parityDiag * projLL ≠ projLL * parityDiag := by

  intro h
  have h_eq : projLL * parityDiag = projRR * parityDiag := by
    rw [← h, parity_swaps_RR_LL]
  apply_fun (· * parityDiag) at h_eq
  rw [mul_assoc, mul_assoc, parityDiag_sq, mul_one, mul_one] at h_eq
  exact projLL_ne_projRR h_eq
