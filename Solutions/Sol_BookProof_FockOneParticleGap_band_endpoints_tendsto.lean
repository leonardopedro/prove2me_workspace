-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.band_endpoints_tendsto
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {lo hi : ℕ → ℝ} {lam : ℝ}
    (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    Tendsto lo atTop (𝓝 lam) ∧ Tendsto hi atTop (𝓝 lam) := by

  have hlo : Tendsto lo atTop (𝓝 lam) := by
    have hsq : ∀ m, lam - (hi m - lo m) ≤ lo m := fun m => by
      have := (hmem m).2; linarith
    have hup : ∀ m, lo m ≤ lam := fun m => (hmem m).1
    have h1 : Tendsto (fun m => lam - (hi m - lo m)) atTop (𝓝 (lam - 0)) :=
      tendsto_const_nhds.sub hwidth
    rw [sub_zero] at h1
    exact tendsto_of_tendsto_of_tendsto_of_le_of_le h1 tendsto_const_nhds hsq hup
  refine ⟨hlo, ?_⟩
  have h2 : Tendsto (fun m => (hi m - lo m) + lo m) atTop (𝓝 (0 + lam)) := hwidth.add hlo
  simpa using h2
