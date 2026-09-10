-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.annA_single
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.annA_single (j : ℕ) (β : Conf) (c : ℂ) :
    annA j (Finsupp.single β c) = c • Finsupp.single (dn j β) ((Real.sqrt (β j) : ℝ) : ℂ) := by sorry
