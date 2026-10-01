-- Generated from ChapterBandEnclosure.lean — theorem BookProof.BandEnclosure.sirk_nestedBands
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

theorem BookProof.BandEnclosure.sirk_nestedBands (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) :
    NestedBands (fun _ => (0 : ℝ)) (fun m => sirkBound C Dmin h nv m) := by sorry
