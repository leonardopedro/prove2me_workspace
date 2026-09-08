-- Generated from ChapterSirkCertifiedGap.lean — solution of BookProof.SirkCertifiedGap.certifiedGap_tendsto
import Mathlib
import Definitions.Def_ChapterSirkCertifiedGap
open BookProof.SirkCertifiedGap











noncomputable section


open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {thetaE thetaO deltaE deltaO : ℕ → ℝ} {lamE lamO : ℝ}
    (hE : Tendsto thetaE atTop (𝓝 lamE)) (hO : Tendsto thetaO atTop (𝓝 lamO))
    (hdE : Tendsto deltaE atTop (𝓝 0)) (hdO : Tendsto deltaO atTop (𝓝 0)) :
    Tendsto (certifiedGap thetaE thetaO deltaE deltaO) atTop (𝓝 (lamO - lamE)) := by

  have h := ((hO.sub hE).sub (hdO.add hdE))
  simpa [certifiedGap] using h
