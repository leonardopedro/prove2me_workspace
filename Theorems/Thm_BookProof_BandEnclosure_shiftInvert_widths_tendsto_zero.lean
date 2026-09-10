-- Generated from ChapterBandEnclosure.lean — theorem BookProof.BandEnclosure.shiftInvert_widths_tendsto_zero
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

theorem BookProof.BandEnclosure.shiftInvert_widths_tendsto_zero {lo hi : ℕ → ℝ} {nu gam : ℝ} (hnu : nu ≠ 0)
    (hlo : Tendsto lo atTop (𝓝 nu)) (hhi : Tendsto hi atTop (𝓝 nu)) :
    Tendsto (fun m => ((lo m)⁻¹ - gam) - ((hi m)⁻¹ - gam)) atTop (𝓝 0) := by sorry
