-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.support_creA
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.support_creA (j : ℕ) (u : FockAlg) : (creA j u).support ⊆ u.support.image (up j) := by sorry
