-- Generated from ChapterYangMillsAbelianFockEsa.lean — theorem BookProof.YmAbelianFock.ymAbelianHermOp_eq
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
open BookProof.YmAbelianFock

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.FiniteSectionSingleTime BookProof.QymTimeIndependent BookProof.QgTimeIndependent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core, and the `24` Weyl-ordered squares of the
-- Yang–Mills Hamiltonian, make the defeq checks of this identification expensive
theorem BookProof.YmAbelianFock.ymAbelianHermOp_eq (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    ymAbelianHermOp e = (coreRepHerm e).op ymAbelianPoly := by sorry
