-- Generated from ChapterBandEnclosure.lean — solution of BookProof.BandEnclosure.sirk_nestedBands
import Mathlib
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterH8
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.BandEnclosure











noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

set_option maxHeartbeats 1000000 in
theorem solution (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) :
    NestedBands (fun _ => (0 : ℝ)) (fun m => sirkBound C Dmin h nv m) := fun m => sirk_band_contained C Dmin h nv hC hD hnv hh m
