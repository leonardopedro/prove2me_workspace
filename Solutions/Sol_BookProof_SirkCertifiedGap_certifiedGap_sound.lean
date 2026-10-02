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

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
 m ≥ m0, 0 < certifiedGap thetaE thetaO deltaE deltaO m := by
  have h := certifiedGap_tendsto hE hO hdE hdO
  have hev := h.eventually (eventually_gt_nhds hmu)
  rcases (eventually_atTop.mp hev) with ⟨m0, hm0⟩
  exact ⟨m0, hm0⟩

theorem solution {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℕ → ℝ} {m : ℕ}
    (hEven : sectorGround T P 1 ≤ thetaE m + deltaE m)
    (hOdd : thetaO m - deltaO m ≤ :=
  sectorGround T P (-1))
      (hpos : 0 < certifiedGap thetaE thetaO deltaE deltaO m) :
      certifiedGap the
