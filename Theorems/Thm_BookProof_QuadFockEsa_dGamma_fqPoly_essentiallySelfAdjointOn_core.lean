-- Generated from ChapterQuadraticFockEsa.lean — theorem BookProof.QuadFockEsa.dGamma_fqPoly_essentiallySelfAdjointOn_core
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.FockSecondQuantization
open BookProof.FullQuadratic
open BookProof.QuadFockEsa



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {d : ℕ}


theorem BookProof.QuadFockEsa.dGamma_fqPoly_essentiallySelfAdjointOn_core (e : ℕ ≃ (Fin d →₀ ℕ))
    (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf)
      (dGammaOp (hermCol e (fqPoly P Q S b b'))) := by sorry
