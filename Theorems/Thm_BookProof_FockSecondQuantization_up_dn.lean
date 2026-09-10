-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.up_dn
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.up_dn (j : ℕ) {α : Conf} (h : 1 ≤ α j) : up j (dn j α) = α := by sorry
