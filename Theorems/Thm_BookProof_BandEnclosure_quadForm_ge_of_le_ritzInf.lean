-- Generated from ChapterBandEnclosure.lean — theorem BookProof.BandEnclosure.quadForm_ge_of_le_ritzInf
import Mathlib
import Definitions.Def_ChapterBandEnclosure
open BookProof.BandEnclosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

theorem BookProof.BandEnclosure.quadForm_ge_of_le_ritzInf {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) {mu : ℝ} (hmu : mu ≤ ritzInf H D) (x : D) :
    mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x := by sorry
