-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.normSq_hFun_le
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution (X : ι → ℂ) (β : ι) :
    ‖S.hFun X β‖ ^ 2
      ≤ 2 * S.hop (fun α => (S.ampSeq X α) ^ 2) β + 2 * (S.ampSeq X (S.shift β)) ^ 2 := by

  have h1 := norm_hFun_le S X β
  have h2 : 0 ≤ S.hop (S.ampSeq X) β := hop_nonneg S (ampSeq_nonneg S X) β
  have h3 : 0 ≤ S.ampSeq X (S.shift β) := ampSeq_nonneg S X _
  have h4 := mul_self_le_mul_self (norm_nonneg (S.hFun X β)) h1
  rw [hop_sq]
  nlinarith [h4, sq_nonneg (S.hop (S.ampSeq X) β - S.ampSeq X (S.shift β))]
