-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.enorm_natCast_complex
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
theorem solution (m : ℕ) : ‖(m : ℂ)‖ₑ = (m : ℝ≥0∞) := by

  rw [← ofReal_norm_eq_enorm, Complex.norm_natCast, ENNReal.ofReal_natCast]
