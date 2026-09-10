-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.ccr_annA_annA
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.ccr_annA_annA (j k : ℕ) (u : FockAlg) : annA j (annA k u) = annA k (annA j u) := by sorry
