-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.certified_parity_gap_pos
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_certified_parity_gap
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    (hsep : 0 < thetaO - thetaE - (deltaO + deltaE)) :
    sectorGround T P 1 < sectorGround T P (-1) := by

  have := certified_parity_gap (T := T) (P := P) hEven hOdd
  linarith
