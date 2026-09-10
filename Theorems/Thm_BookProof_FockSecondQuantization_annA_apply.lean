-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.annA_apply
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.annA_apply (j : ℕ) (u : FockAlg) (α : Conf) :
    annA j u α = ((Real.sqrt ((α j : ℝ) + 1) : ℝ) : ℂ) * u (up j α) := by sorry
