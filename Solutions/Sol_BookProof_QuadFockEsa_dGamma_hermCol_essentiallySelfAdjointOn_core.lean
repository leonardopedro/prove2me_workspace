-- Generated from ChapterQuadraticFockEsa.lean — solution of BookProof.QuadFockEsa.dGamma_hermCol_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Theorems.Thm_BookProof_QuadFockEsa_gradedBand_of_isBand2
import Theorems.Thm_BookProof_FockSecondQuantization_isHermCol_opCol
import Theorems.Thm_BookProof_GradedBandSchur_dGamma_essentiallySelfAdjointOn_core_gradedBand
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterYangMillsHermite
open BookProof.QuadFockEsa




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.FockSecondQuantization
open BookProof.HermiteBand
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin d →₀ ℕ))
    {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)} (hsym : PolySym T) (h : IsBand2 T) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (hermCol e T)) := by

  obtain ⟨M, C, hC, hcard, hband, hent⟩ := gradedBand_of_isBand2 e h
  exact dGamma_essentiallySelfAdjointOn_core_gradedBand (deg := fun k => (e k).degree)
    (D := 2) (M := M) hC (isHermCol_opCol ((coreRepHerm e).symmetricOn_op hsym))
    hcard hband hent
