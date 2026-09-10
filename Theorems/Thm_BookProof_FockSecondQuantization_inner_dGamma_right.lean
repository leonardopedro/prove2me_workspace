-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.inner_dGamma_right
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.inner_dGamma_right (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) {L : Finset ℕ}
    (hv : modes v ⊆ L)
    (hL : ∀ k ∈ modes u ∪ modes v, (col k).support ⊆ L) :
    (inner ℂ (toLp u) (toLp (dGamma col v)) : ℂ)
      = ∑ j ∈ L, ∑ k ∈ L,
        (col j) k * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by sorry
