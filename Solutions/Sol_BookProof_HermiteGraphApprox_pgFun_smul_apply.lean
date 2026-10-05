-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.pgFun_smul_apply
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (c • p) x = c * pgFun p x := by

  simp [pgFun, smul_eq_C_mul, mul_assoc]
