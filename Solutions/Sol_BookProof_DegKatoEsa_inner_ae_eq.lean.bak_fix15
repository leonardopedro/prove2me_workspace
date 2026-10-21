-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.inner_ae_eq
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
open BookProof.DegKatoEsa




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : L2d d) (g : Vd d → ℂ) (hg : (a : Vd d → ℂ) =ᵐ[volume] g)
    (u : L2d d) : (inner ℂ a u : ℂ) = ∫ x, (starRingEnd ℂ) (g x) * (u : Vd d → ℂ) x := by

  rw [MeasureTheory.L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [hg] with x hx
  rw [← hx]
  simp [RCLike.inner_apply, mul_comm]
