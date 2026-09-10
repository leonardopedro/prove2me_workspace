-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.ccr_creA_creA
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.ccr_creA_creA (j k : ℕ) (u : FockAlg) : creA j (creA k u) = creA k (creA j u) := by sorry
