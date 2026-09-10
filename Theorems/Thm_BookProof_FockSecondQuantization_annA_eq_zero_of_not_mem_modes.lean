-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.annA_eq_zero_of_not_mem_modes
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.annA_eq_zero_of_not_mem_modes {u : FockAlg} {k : ℕ} (h : k ∉ modes u) :
    annA k u = 0 := by sorry
