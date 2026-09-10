-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.toLp_apply
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.toLp_apply (u : FockAlg) (α : Conf) : ((toLp u : Fock) : Conf → ℂ) α = u α := by sorry
