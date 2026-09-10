-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.dGamma_one_particle
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.dGamma_one_particle (col : ℕ → (ℕ →₀ ℂ)) (k : ℕ) :
    dGamma col (Finsupp.single (Finsupp.single k 1) 1)
      = ∑ j ∈ (col k).support, (col k) j • Finsupp.single (Finsupp.single j 1) (1 : ℂ) := by sorry
