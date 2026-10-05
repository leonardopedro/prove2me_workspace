-- Generated from ChapterQgOuterFockFullFL.lean — solution of BookProof.QgOuterFockFullFL.qgSectorExt_core
import Mathlib
import Definitions.Def_ChapterQgOuterFockFullFL
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_core
open BookProof.QgOuterFockFullFL




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.Qg3DGaugeEsa BookProof.QuantumGravity3DGauge
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine
open Filter Topology

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (p : polyGaussCore (d := n * 84))
    (h : (p : L2d (n * 84)) ∈ (harmFried (n * 84)).dom) :
    qgSectorExt n ⟨(p : L2d (n * 84)), h⟩ = qgSectorHam n p := (qgSectorData n).ext_core p
