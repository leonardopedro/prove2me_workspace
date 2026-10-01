-- Generated from ChapterBandEnclosure.lean — theorem BookProof.BandEnclosure.quadForm_real_smul
import Mathlib
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

theorem BookProof.BandEnclosure.quadForm_real_smul {D : Submodule ℂ F} (H : D →ₗ[ℂ] F) (c : ℝ) (x : D) :
    quadForm H ((c : ℂ) • x) = c ^ 2 * quadForm H x := by sorry
