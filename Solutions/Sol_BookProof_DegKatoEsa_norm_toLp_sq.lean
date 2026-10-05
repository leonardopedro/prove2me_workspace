-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.norm_toLp_sq
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_inner_toLp
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
theorem solution {f : Vd d → ℂ} (hf : MemLp f 2 (volume : Measure (Vd d))) :
    ‖hf.toLp f‖ ^ 2 = ∫ x, ‖f x‖ ^ 2 := by

  have h := inner_toLp hf hf
  have hpt : ∀ x, (starRingEnd ℂ) (f x) * f x = ((‖f x‖ ^ 2 : ℝ) : ℂ) := by
    intro x
    rw [Complex.conj_mul']
    norm_cast
  rw [integral_congr_ae (Filter.Eventually.of_forall hpt), integral_complex_ofReal] at h
  have h2 := congrArg Complex.re h
  rw [Complex.ofReal_re] at h2
  rw [← h2, ← inner_self_eq_norm_sq (𝕜 := ℂ)]
  rfl
