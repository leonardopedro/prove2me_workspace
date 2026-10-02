-- Generated from ChapterBandEnclosure.lean — solution of BookProof.BandEnclosure.shiftInvert_band_enclosure
import Mathlib
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure



noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {lo hi : ℕ → ℝ} {nu lam gam : ℝ}
    (hlopos : ∀ m, 0 < lo m) (hband : ∀ m, nu ∈ Set.Icc (lo m) (hi m))
    (hmap : lam = nu⁻¹ - gam) :
    ∀ m, lam ∈ Set.Icc ((hi m)⁻¹ - gam) ((lo m)⁻¹ - gam) := by

  intro m
  obtain ⟨h1, h2⟩ := hband m
  have hnu : 0 < nu := lt_of_lt_of_le (hlopos m) h1
  subst hmap
  constructor
  · gcongr
  · gcongr
    exact hlopos m
