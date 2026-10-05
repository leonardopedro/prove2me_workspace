-- Generated from ChapterQgOuterFockEllipticFL.lean — solution of BookProof.QgOuterFockElliptic.outerHam_qgKappa
import Mathlib
import Definitions.Def_ChapterQgOuterFockEllipticFL
import Theorems.Thm_BookProof_QgOuterFockElliptic_sectorHam_qgKappa
open BookProof.QgOuterFockElliptic



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuantumGravity3DGauge
open BookProof.QgOuterFock
open BookProof.QgOuterFockFL
open BookProof.DirectSumEsa
open BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : ℕ}
variable {I : Type*} {G : I → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] [∀ i, CompleteSpace (G i)]

set_option maxHeartbeats 1000000 in
theorem solution : outerHam qgKappa = qgOuterHam := congrArg dsOp (funext fun n => sectorHam_qgKappa n)
