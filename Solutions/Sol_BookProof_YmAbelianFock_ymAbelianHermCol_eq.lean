-- Generated from ChapterYangMillsAbelianFockEsa.lean — solution of BookProof.YmAbelianFock.ymAbelianHermCol_eq
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Theorems.Thm_BookProof_YmAbelianFock_ymAbelianHermOp_eq
open BookProof.YmAbelianFock




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.FiniteSectionSingleTime BookProof.QgTimeIndependent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    ymAbelianHermCol e = hermCol e ymAbelianPoly := by

  rw [ymAbelianHermCol, ymAbelianHermOp_eq, hermCol]
