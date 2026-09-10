-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.support_subset_modes
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.support_subset_modes {u : FockAlg} {β : Conf} (h : β ∈ u.support) :
    β.support ⊆ modes u := by sorry
