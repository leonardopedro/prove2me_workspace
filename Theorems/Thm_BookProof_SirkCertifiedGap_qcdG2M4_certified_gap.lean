-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.qcdG2M4_certified_gap
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.ChapterGravityProjector
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.SirkCertifiedGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]


noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision


2M4_lower : qcdG2M4.lower = 1.932 := by
  norm_num [GapCertificate.lower, qcdG2M4]

theorem BookProof.SirkCertifiedGap.qcdG2M4_certified_gap : 0 < qcdG2M4.lower := by
  rw [qcdG2M4_lower]; norm_num

omit [FiniteDimensional ℂ E] in
/-- **The instantiated certified mass gap for the truncated operator.**  Given the two
enclosures the `g = 2`, `m = 4` certificate asserts, the truncated Hamiltonian
has a strictly positive parity gap, of size at least `1.932`. -/
theorem qcdG2M4_certified_gap {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : thetaO - thetaE = 1.9875) (hwidth : deltaO + delta := by sorry
