-- Generated from ChapterQuadraticFockEsa.lean — theorem BookProof.QuadFockEsa.dGamma_fqPoly_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
open BookProof.QuadFockEsa

variable {d : ℕ}



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
