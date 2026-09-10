-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.band_endpoints_tendsto
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap












noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.band_endpoints_tendsto {lo hi : ℕ → ℝ} {lam : ℝ}
    (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    Tendsto lo atTop (𝓝 lam) ∧ Tendsto hi atTop (𝓝 lam) := by sorry
