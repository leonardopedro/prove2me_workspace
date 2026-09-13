-- Generated from ChapterBandEnclosure.lean — solution of BookProof.BandEnclosure.band_enclosure_endpoints_tendsto
import Mathlib
import Definitions.Def_ChapterBandEnclosure
import Theorems.Thm_BookProof_BandEnclosure_band_enclosure_of_nested
import Theorems.Thm_BookProof_BandEnclosure_band_limit_unique
import Theorems.Thm_BookProof_FockOneParticleGap_band_endpoints_tendsto
import Definitions.Def_ChapterH8
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.BandEnclosure











noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

set_option maxHeartbeats 1000000 in
theorem solution {lo hi a : ℕ → ℝ} {lam : ℝ}
    (hnest : NestedBands lo hi) (hmem : ∀ m, a m ∈ Set.Icc (lo m) (hi m))
    (hconv : Tendsto a atTop (𝓝 lam))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    (∀ m, lam ∈ Set.Icc (lo m) (hi m)) ∧
      (∀ lam', (∀ m, lam' ∈ Set.Icc (lo m) (hi m)) → lam' = lam) ∧
      Tendsto lo atTop (𝓝 lam) ∧ Tendsto hi atTop (𝓝 lam) := by

  have hband := band_enclosure_of_nested hnest hmem hconv
  exact ⟨hband, fun lam' h' => band_limit_unique h' hband hwidth,
    (band_endpoints_tendsto hband hwidth).1, (band_endpoints_tendsto hband hwidth).2⟩
