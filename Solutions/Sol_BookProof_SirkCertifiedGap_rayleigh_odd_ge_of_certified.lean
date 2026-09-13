-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.rayleigh_odd_ge_of_certified
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_sectorGround_le_rayleigh
import Theorems.Thm_BookProof_SirkCertifiedGap_certified_parity_gap
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hT : T.IsSymmetric)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    {x : E} (hx : ‖x‖ = 1) (hmem : x ∈ paritySector P (-1)) :
    sectorGround T P 1 + (thetaO - thetaE - (deltaO + deltaE)) ≤ rayleigh T x := by

  have h1 : sectorGround T P (-1) ≤ rayleigh T x :=
    sectorGround_le_rayleigh (P := P) (s := -1) hT hx hmem
  have h2 := certified_parity_gap (T := T) (P := P) hEven hOdd
  linarith
