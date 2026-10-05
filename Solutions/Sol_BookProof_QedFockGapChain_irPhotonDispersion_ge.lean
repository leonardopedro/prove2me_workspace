-- Generated from ChapterQedFockGapChain.lean — solution of BookProof.QedFockGapChain.irPhotonDispersion_ge
import Mathlib
import Definitions.Def_ChapterQedFockGapChain
open BookProof.QedFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FarisLavine
open BookProof.HermiteGalerkin BookProof.HermiteCore
open BookProof.FockDiagonalGapChain BookProof.YangMillsFriedrichs
open MeasureTheory


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (mu : ℝ) (p : ℕ → ℝ) (k : ℕ) :
    mu ≤ irPhotonDispersion mu p k := le_max_left _ _
