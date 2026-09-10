-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.support_up
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.support_up (j : ℕ) (α : Conf) : (up j α).support ⊆ insert j α.support := by sorry
