-- Generated from ChapterBandEnclosure.lean — theorem BookProof.BandEnclosure.band_limit_unique
import Mathlib
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure










noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

theorem BookProof.BandEnclosure.band_limit_unique {lo hi : ℕ → ℝ} {lam lam' : ℝ}
    (h : ∀ m, lam ∈ Set.Icc (lo m) (hi m)) (h' : ∀ m, lam' ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    lam = lam' := by sorry
