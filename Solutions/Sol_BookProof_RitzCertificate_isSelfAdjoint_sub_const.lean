-- Generated from ChapterRitzCertificate.lean — solution of BookProof.RitzCertificate.isSelfAdjoint_sub_const
import Mathlib
import Definitions.Def_ChapterRitzCertificate
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterBandEnclosure
open BookProof.RitzCertificate














noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) (c : ℝ) :
    IsSelfAdjoint (A - (c : ℝ) • (1 : F →L[ℂ] F)) := by

  simp [IsSelfAdjoint, star_sub, hA.star_eq]
