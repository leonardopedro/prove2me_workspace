-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.inner_dGamma_left
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.inner_dGamma_left (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) {L : Finset ℕ}
    (hu : modes u ⊆ L)
    (hL : ∀ k ∈ modes u ∪ modes v, (col k).support ⊆ L) :
    (inner ℂ (toLp (dGamma col u)) (toLp v) : ℂ)
      = ∑ k ∈ L, ∑ j ∈ L,
        (starRingEnd ℂ) ((col k) j) * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by sorry
