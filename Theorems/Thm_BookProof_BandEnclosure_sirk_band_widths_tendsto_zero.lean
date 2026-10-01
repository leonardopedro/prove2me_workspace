-- Generated from ChapterBandEnclosure.lean — theorem BookProof.BandEnclosure.sirk_band_widths_tendsto_zero
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterH8
import Mathlib
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterH6
open BookProof.ChapterH6
open BookProof.BandEnclosure


noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

theorem BookProof.BandEnclosure.sirk_band_widths_tendsto_zero (C Dmin h nv : ℝ) (hh : 0 < h) :
    Tendsto (fun m => sirkBound C Dmin h nv m - 0) atTop (𝓝 0) := by sorry
