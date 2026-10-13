-- Generated from ChapterQuadraticFockEsa.lean — solution of BookProof.QuadFockEsa.dGamma_fqPoly_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Theorems.Thm_BookProof_QuadFockEsa_dGamma_hermCol_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_FullQuadratic_polySym_fqPoly
import Theorems.Thm_BookProof_HermiteBand_isBand2_fqPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.QuadFockEsa




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.FockSecondQuantization
open BookProof.FullQuadratic

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin d →₀ ℕ))
    (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf)
      (dGammaOp (hermCol e (fqPoly P Q S b b'))) :=
  dGamma_hermCol_essentiallySelfAdjointOn_core e (polySym_fqPoly P Q S b b')
      (isBand2_fqPoly P Q S b b')
