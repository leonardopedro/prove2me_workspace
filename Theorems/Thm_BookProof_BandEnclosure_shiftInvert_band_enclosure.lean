-- Generated from ChapterBandEnclosure.lean — theorem BookProof.BandEnclosure.shiftInvert_band_enclosure
import Mathlib
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterFriedrichsFormGap
open BookProof.BandEnclosure










noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8















open BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit BookProof.ChapterSirkRitzSpectrum

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]













open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert BookProof.FriedrichsExtension
open BookProof.FriedrichsFormGap

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.BandEnclosure.shiftInvert_band_enclosure {lo hi : ℕ → ℝ} {nu lam gam : ℝ}
    (hlopos : ∀ m, 0 < lo m) (hband : ∀ m, nu ∈ Set.Icc (lo m) (hi m))
    (hmap : lam = nu⁻¹ - gam) :
    ∀ m, lam ∈ Set.Icc ((hi m)⁻¹ - gam) ((lo m)⁻¹ - gam) := by sorry
