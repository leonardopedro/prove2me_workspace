-- Generated from ChapterQgOuterFockFullFL.lean — solution of BookProof.QgOuterFockFullFL.qgFLc_nonneg
import Mathlib
import Definitions.Def_ChapterQgOuterFockFullFL
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
theorem solution : 0 ≤ qgFLc := by
 norm_num [qgFLc]
