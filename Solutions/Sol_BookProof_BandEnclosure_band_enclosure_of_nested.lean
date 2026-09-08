-- Generated from ChapterBandEnclosure.lean — solution of BookProof.BandEnclosure.band_enclosure_of_nested
import Mathlib
import Definitions.Def_ChapterBandEnclosure
import Theorems.Thm_BookProof_BandEnclosure_nestedBands_le
open BookProof.BandEnclosure











noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

set_option maxHeartbeats 1000000 in
theorem solution {lo hi a : ℕ → ℝ} {lam : ℝ}
    (hnest : NestedBands lo hi) (hmem : ∀ m, a m ∈ Set.Icc (lo m) (hi m))
    (hconv : Tendsto a atTop (𝓝 lam)) :
    ∀ m, lam ∈ Set.Icc (lo m) (hi m) := by

  intro m
  have hev : ∀ᶠ n in atTop, a n ∈ Set.Icc (lo m) (hi m) := by
    filter_upwards [eventually_ge_atTop m] with n hn
    exact nestedBands_le hnest hn (hmem n)
  exact ⟨ge_of_tendsto hconv (hev.mono fun _ hn => hn.1),
    le_of_tendsto hconv (hev.mono fun _ hn => hn.2)⟩
