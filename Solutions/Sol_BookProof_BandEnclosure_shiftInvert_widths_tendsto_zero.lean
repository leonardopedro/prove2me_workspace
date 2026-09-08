-- Generated from ChapterBandEnclosure.lean — solution of BookProof.BandEnclosure.shiftInvert_widths_tendsto_zero
import Mathlib
import Definitions.Def_ChapterBandEnclosure
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

set_option maxHeartbeats 1000000 in
theorem solution {lo hi : ℕ → ℝ} {nu gam : ℝ} (hnu : nu ≠ 0)
    (hlo : Tendsto lo atTop (𝓝 nu)) (hhi : Tendsto hi atTop (𝓝 nu)) :
    Tendsto (fun m => ((lo m)⁻¹ - gam) - ((hi m)⁻¹ - gam)) atTop (𝓝 0) := by

  have h1 : Tendsto (fun m => (lo m)⁻¹) atTop (𝓝 nu⁻¹) := hlo.inv₀ hnu
  have h2 : Tendsto (fun m => (hi m)⁻¹) atTop (𝓝 nu⁻¹) := hhi.inv₀ hnu
  have := (h1.sub_const gam).sub (h2.sub_const gam)
  simpa using this
