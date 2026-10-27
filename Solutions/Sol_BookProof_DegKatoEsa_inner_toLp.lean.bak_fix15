-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.inner_toLp
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
theorem solution {f g : Vd d → ℂ} (hf : MemLp f 2 (volume : Measure (Vd d)))
    (hg : MemLp g 2 (volume : Measure (Vd d))) :
    (inner ℂ (hf.toLp f) (hg.toLp g) : ℂ) = ∫ x, (starRingEnd ℂ) (f x) * g x := by

  rw [L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [hf.coeFn_toLp, hg.coeFn_toLp] with x h1 h2
  rw [h1, h2, RCLike.inner_apply, mul_comm]
