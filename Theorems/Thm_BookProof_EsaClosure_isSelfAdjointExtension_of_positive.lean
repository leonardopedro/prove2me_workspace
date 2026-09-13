-- Generated from ChapterEsaClosure.lean — theorem BookProof.EsaClosure.isSelfAdjointExtension_of_positive
import Mathlib
import Definitions.Def_ChapterEsaClosure
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterSirkBandLedger
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

theorem BookProof.EsaClosure.isSelfAdjointExtension_of_positive {D Dom : Submodule ℂ F} {H : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (h : IsPositiveSelfAdjointExtension H A) : IsSelfAdjointExtension H A := by sorry
