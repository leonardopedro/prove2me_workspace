-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.coe_fockEquiv
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

   rfl

theorem BookProof.FockSecondQuantization.coe_fockEquiv (u : FockAlg) : ((fockEquiv u : lpFiniteModes Conf) : Fock)
    = := by sorry
