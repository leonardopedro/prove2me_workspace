-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.inner_pgLp_ae
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
theorem solution {h : MvPolynomial (Fin d) ℂ} {v : L2d d} {g : Vd d → ℂ}
    (hv : (v : Vd d → ℂ) =ᵐ[volume] g) :
    (inner ℂ (pgLp h) v : ℂ) = ∫ x, (starRingEnd ℂ) (pgFun h x) * g x := by

  rw [L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [pgLp_coeFn h, hv] with x h1 h2
  rw [h1, h2, RCLike.inner_apply, mul_comm]
