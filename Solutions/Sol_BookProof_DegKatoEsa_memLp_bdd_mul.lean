-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.memLp_bdd_mul
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
theorem solution {b f : Vd d → ℂ} (hb : Continuous b) {B : ℝ} (hbB : ∀ x, ‖b x‖ ≤ B)
    (hf : MemLp f 2 (volume : Measure (Vd d))) :
    MemLp (fun x => b x * f x) 2 (volume : Measure (Vd d)) := by

  refine MemLp.of_le (hf.const_mul (B : ℂ)) (hb.aestronglyMeasurable.mul hf.1) ?_
  filter_upwards with x
  have hB : 0 ≤ B := (norm_nonneg _).trans (hbB x)
  rw [norm_mul, norm_mul, Complex.norm_real, Real.norm_of_nonneg hB]
  exact mul_le_mul_of_nonneg_right (hbB x) (norm_nonneg _)
