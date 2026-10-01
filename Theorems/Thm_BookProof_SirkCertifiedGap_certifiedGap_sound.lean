-- Generated from ChapterSirkCertifiedGap.lean — theorem BookProof.SirkCertifiedGap.certifiedGap_sound
import Definitions.Def_ChapterSirkFinitePrecision
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]


noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision


 m ≥ m0, 0 < certifiedGap thetaE thetaO deltaE deltaO m := by
  have h := certifiedGap_tendsto hE hO hdE hdO
  have hev := h.eventually (eventually_gt_nhds hmu)
  rcases (eventually_atTop.mp hev) with ⟨m0, hm0⟩
  exact ⟨m0, hm0⟩

theorem BookProof.SirkCertifiedGap.certifiedGap_sound {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℕ → ℝ} {m : ℕ}
    (hEven : sectorGround T P 1 ≤ thetaE m + deltaE m)
    (hOdd : thetaO m - deltaO m ≤ := by sorry
