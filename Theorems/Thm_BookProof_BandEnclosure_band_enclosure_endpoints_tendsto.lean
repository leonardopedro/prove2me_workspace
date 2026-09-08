-- Generated from ChapterBandEnclosure.lean — theorem BookProof.BandEnclosure.band_enclosure_endpoints_tendsto
import Mathlib
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure










noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

theorem BookProof.BandEnclosure.band_enclosure_endpoints_tendsto {lo hi a : ℕ → ℝ} {lam : ℝ}
    (hnest : NestedBands lo hi) (hmem : ∀ m, a m ∈ Set.Icc (lo m) (hi m))
    (hconv : Tendsto a atTop (𝓝 lam))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    (∀ m, lam ∈ Set.Icc (lo m) (hi m)) ∧
      (∀ lam', (∀ m, lam' ∈ Set.Icc (lo m) (hi m)) → lam' = lam) ∧
      Tendsto lo atTop (𝓝 lam) ∧ Tendsto hi atTop (𝓝 lam) := by sorry
