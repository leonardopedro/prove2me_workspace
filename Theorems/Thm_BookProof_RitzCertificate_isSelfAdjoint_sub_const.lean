-- Generated from ChapterRitzCertificate.lean — theorem BookProof.RitzCertificate.isSelfAdjoint_sub_const
import Mathlib
import Definitions.Def_ChapterRitzCertificate
open BookProof.RitzCertificate













noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzCertificate.isSelfAdjoint_sub_const {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) (c : ℝ) :
    IsSelfAdjoint (A - (c : ℝ) • (1 : F →L[ℂ] F)) := by sorry
