-- Generated from ChapterBandEnclosure.lean — solution of BookProof.BandEnclosure.sirk_band_widths_tendsto_zero
import Mathlib
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure











noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

set_option maxHeartbeats 1000000 in
theorem solution (C Dmin h nv : ℝ) (hh : 0 < h) :
    Tendsto (fun m => sirkBound C Dmin h nv m - 0) atTop (𝓝 0) := by

  simpa using sirk_error_decay_exponential C Dmin h nv hh
