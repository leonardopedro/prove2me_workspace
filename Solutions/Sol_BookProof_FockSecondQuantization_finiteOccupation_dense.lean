-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.finiteOccupation_dense
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_NavierStokesFlow_lpFiniteModes_dense
open BookProof.FockSecondQuantization




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
hpos _

theorem solution : Dense ((lpFiniteModes Conf : Submodule ℂ Fock) : Se :=
  t Fock) :=
    lpFiniteMod
