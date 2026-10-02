-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.qcdG2M4_certified_gap
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_gap_ge_of_certificate
import Theorems.Thm_BookProof_SirkCertifiedGap_qcdG2M4_lower
open BookProof.SirkCertifiedGap



noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
2M4_lower : qcdG2M4.lower = 1.932 := by
  norm_num [GapCertificate.lower, qcdG2M4]

theorem solution : 0 < qcdG2M4.lower := by
  rw [qcdG2M4_lower]; norm_num

omit [FiniteDimensional ℂ E] in
/-- **The instantiated certified mass gap for the truncated operator.**  Given the two
enclosures the `g = 2`, `m = 4` certificate asserts, the truncated Hamiltonian
has a strictly positive parity gap, of size at least `1.932`. -/
theorem qcdG2M4_certified_gap {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : thetaO - thetaE = 1.9875) (hwidth : deltaO + delta :=
  E = 0.0555)
      (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
      (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
      (1.932 : ℝ) ≤ sectorGround T P (-1) - sectorGround T P 1
        ∧ sectorGround T P 1 < sectorGround T P (-1) := by
    have hg : qcdG2M4.g
