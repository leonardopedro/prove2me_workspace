-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.certified_parity_gap_of_data
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap










noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

theorem BookProof.SirkCertifiedGap.certified_parity_gap_of_data {T P : E →ₗ[ℂ] E} (hT : T.IsSymmetric)
    {vE : E} (hvE : ‖vE‖ = 1) (hvEmem : vE ∈ paritySector P 1)
    {thetaE thetaO deltaE deltaO : ℝ} (hthetaE : rayleigh T vE = thetaE) (hdE : 0 ≤ deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    thetaO - thetaE - (deltaO + deltaE) ≤ sectorGround T P (-1) - sectorGround T P 1 := by sorry
