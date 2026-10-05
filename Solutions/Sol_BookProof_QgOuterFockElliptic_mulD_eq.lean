-- Generated from ChapterQgOuterFockEllipticFL.lean — solution of BookProof.QgOuterFockElliptic.mulD_eq
import Mathlib
import Definitions.Def_ChapterQgOuterFockEllipticFL



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

set_option maxHeartbeats 1000000 in
theorem solution (f : MvPolynomial (Fin D) ℂ) : coreOp (YangMillsHermite.mulOp f) = mulD f := rfl
