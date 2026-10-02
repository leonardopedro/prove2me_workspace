-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.gap_ge_of_certificate
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_certified_parity_gap
open BookProof.SirkCertifiedGap



noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
ified width `δᵒ + δᵉ`. -/
  width : ℝ
  theorem solution {T P : E →ₗ[ℂ] E} (c : GapCertificate)
    {thetaE thetaO deltaE deltaO : ℝ} :=
   (hgap : c.gap = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
      (hEven : sectorGround T P 1 ≤ thetaE + delt
