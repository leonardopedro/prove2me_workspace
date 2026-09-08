-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.certified_parity_gap_strong_coupling
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap










noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

theorem BookProof.SirkCertifiedGap.certified_parity_gap_strong_coupling {T P : E →ₗ[ℂ] E}
    {thetaE thetaO deltaE deltaO g corr : ℝ}
    (hform : thetaO - thetaE = g ^ 2 / 2 + corr)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    g ^ 2 / 2 + corr - (deltaO + deltaE)
      ≤ sectorGround T P (-1) - sectorGround T P 1 := by sorry
