-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.coe_fockEquiv
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (u : FockAlg) : ((fockEquiv u : lpFiniteModes Conf) : Fock)
    = toLp u := rfl
