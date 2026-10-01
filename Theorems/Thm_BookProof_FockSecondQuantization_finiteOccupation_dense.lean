-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.finiteOccupation_dense
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

hpos _

theorem BookProof.FockSecondQuantization.finiteOccupation_dense : Dense ((lpFiniteModes Conf : Submodule ℂ Fock) : Se := by sorry
