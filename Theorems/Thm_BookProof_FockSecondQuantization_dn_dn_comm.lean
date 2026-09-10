-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.dn_dn_comm
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.dn_dn_comm (j k : ℕ) (α : Conf) : dn k (dn j α) = dn j (dn k α) := by sorry
