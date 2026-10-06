-- Generated from ChapterQuadraticFockEsa.lean — solution of BookProof.QuadFockEsa.dGamma_fqPoly_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Theorems.Thm_BookProof_QuadFockEsa_dGamma_hermCol_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_FullQuadratic_polySym_fqPoly
import Theorems.Thm_BookProof_HermiteBand_isBand2_fqPoly
open BookProof.QuadFockEsa




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

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
