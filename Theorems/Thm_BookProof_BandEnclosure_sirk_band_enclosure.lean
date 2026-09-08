-- Generated from ChapterBandEnclosure.lean — theorem BookProof.BandEnclosure.sirk_band_enclosure
import Mathlib
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure










noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

theorem BookProof.BandEnclosure.sirk_band_enclosure (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 < h)
    {a : ℕ → ℝ} {lam : ℝ}
    (hmem : ∀ m, a m ∈ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv m))
    (hconv : Tendsto a atTop (𝓝 lam)) :
    (∀ m, lam ∈ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv m)) ∧
      (∀ lam', (∀ m, lam' ∈ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv m)) → lam' = lam) ∧
      Tendsto (fun m => sirkBound C Dmin h nv m) atTop (𝓝 lam) := by sorry
