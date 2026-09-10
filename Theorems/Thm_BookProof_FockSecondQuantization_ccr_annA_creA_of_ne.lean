-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.ccr_annA_creA_of_ne
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.ccr_annA_creA_of_ne {j k : ℕ} (h : j ≠ k) (u : FockAlg) :
    annA j (creA k u) = creA k (annA j u) := by sorry
