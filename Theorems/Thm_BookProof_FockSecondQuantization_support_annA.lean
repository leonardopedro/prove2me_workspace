-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.support_annA
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.support_annA (j : ℕ) (u : FockAlg) : (annA j u).support ⊆ u.support.image (dn j) := by sorry
