-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.isBandR_one_op
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    IsBandR 0 0 (LinearMap.id : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) := by

  classical
  refine ⟨1, 1, zero_le_one, fun α => ⟨Finsupp.single α 1, ?_, ?_, ?_, ?_⟩⟩
  · rw [hcomb, Finsupp.linearCombination_single]
    simp
  · exact le_trans (Finset.card_le_card Finsupp.support_single_subset) (by simp)
  · intro β hβ
    have hβ' : β = α := Finset.mem_singleton.mp (Finsupp.support_single_subset hβ)
    subst hβ'
    simp
  · intro β
    rw [Finsupp.single_apply]
    split <;> simp [gpow]
