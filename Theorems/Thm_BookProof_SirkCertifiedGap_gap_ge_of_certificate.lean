-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.gap_ge_of_certificate
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


ified width `δᵒ + δᵉ`. -/
  width : ℝ
  theorem BookProof.SirkCertifiedGap.gap_ge_of_certificate {T P : E →ₗ[ℂ] E} (c : GapCertificate)
    {thetaE thetaO deltaE deltaO : ℝ} := by sorry
