-- Generated from ChapterYangMillsBandBounds.lean — theorem BookProof.YangMillsBandBounds.ymHermOp_eq
import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds
open BookProof.YangMillsBandBounds












noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.HermiteBandHigher BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs BookProof.YmAbelianFock
open BookProof.NavierStokesFlow.DifferentialL2 BookProof.HermiteRelative

set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core and the `24` Weyl-ordered squares of the
-- Yang–Mills Hamiltonian make the defeq checks of this identification expensive
theorem BookProof.YangMillsBandBounds.ymHermOp_eq (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ymHermOp e fabc = (coreRepHerm e).op (ymPoly fabc) := by sorry
