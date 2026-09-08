-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.certifiedGap_sound
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_certified_parity_gap
import Theorems.Thm_BookProof_SirkCertifiedGap_certified_parity_gap_pos
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℕ → ℝ} {m : ℕ}
    (hEven : sectorGround T P 1 ≤ thetaE m + deltaE m)
    (hOdd : thetaO m - deltaO m ≤ sectorGround T P (-1))
    (hpos : 0 < certifiedGap thetaE thetaO deltaE deltaO m) :
    certifiedGap thetaE thetaO deltaE deltaO m
        ≤ sectorGround T P (-1) - sectorGround T P 1
      ∧ sectorGround T P 1 < sectorGround T P (-1) := by

  refine ⟨certified_parity_gap hEven hOdd, ?_⟩
  exact certified_parity_gap_pos hEven hOdd hpos
