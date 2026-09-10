-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.inner_annA_creVec
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.inner_annA_creVec (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) (j : ℕ) {L : Finset ℕ}
    (h : (col j).support ⊆ L) :
    (inner ℂ (toLp u) (toLp (creVec (col j) (annA j v))) : ℂ)
      = ∑ k ∈ L, (col j) k * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by sorry
