-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.certifiedGap_eventually_pos
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
import Theorems.Thm_BookProof_SirkCertifiedGap_certifiedGap_tendsto
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {thetaE thetaO deltaE deltaO : ℕ → ℝ} {lamE lamO : ℝ}
    (hE : Tendsto thetaE atTop (𝓝 lamE)) (hO : Tendsto thetaO atTop (𝓝 lamO))
    (hdE : Tendsto deltaE atTop (𝓝 0)) (hdO : Tendsto deltaO atTop (𝓝 0))
    (hmu : 0 < lamO - lamE) :
    ∃ m0 : ℕ, ∀ m ≥ m0, 0 < certifiedGap thetaE thetaO deltaE deltaO m := by

  have h := certifiedGap_tendsto hE hO hdE hdO
  have hev := h.eventually (eventually_gt_nhds hmu)
  rcases (eventually_atTop.mp hev) with ⟨m0, hm0⟩
  exact ⟨m0, hm0⟩
