-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.up_of_ne
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.up_of_ne {i j : ℕ} (α : Conf) (h : i ≠ j) : up j α i = α i := by sorry
