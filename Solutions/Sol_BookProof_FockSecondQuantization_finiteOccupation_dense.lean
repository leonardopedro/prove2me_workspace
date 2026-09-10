-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.finiteOccupation_dense
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Dense ((lpFiniteModes Conf : Submodule ℂ Fock) : Set Fock) := lpFiniteModes_dense
