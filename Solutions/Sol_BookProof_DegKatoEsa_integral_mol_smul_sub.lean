-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.integral_mol_smul_sub
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_contDiff_mol
import Theorems.Thm_BookProof_DegKatoEsa_hasCompactSupport_mol
import Theorems.Thm_BookProof_DegKatoEsa_integral_mol
import Theorems.Thm_BookProof_DegEnergy_contDiff_cx
import Theorems.Thm_BookProof_DegEnergy_hasCompactSupport_cx
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
theorem solution {f : Vd d → ℂ} (hf : LocallyIntegrable f (volume : Measure (Vd d)))
    (n : ℕ) (x : Vd d) :
    ∫ y, mol d n y • (f (x - y) - f x) = cnv f (cx (mol d n)) x - f x := by

  have hρC : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cx (mol d n)) := contDiff_cx (contDiff_mol n)
  have hρc : HasCompactSupport (cx (mol d n)) := hasCompactSupport_cx (hasCompactSupport_mol n)
  have hex : ConvolutionExistsAt f (cx (mol d n)) x (ContinuousLinearMap.mul ℝ ℂ) volume :=
    hρc.convolutionExists_right (ContinuousLinearMap.mul ℝ ℂ) hf hρC.continuous x
  have hsw : Integrable (fun t => f (x - t) * cx (mol d n) t) (volume : Measure (Vd d)) :=
    hex.integrable_swap
  have hcnv : cnv f (cx (mol d n)) x = ∫ t, f (x - t) * cx (mol d n) t := by
    rw [cnv, convolution_eq_swap]
    rfl
  have hint2 : Integrable (fun t => cx (mol d n) t * f x) (volume : Measure (Vd d)) :=
    (hρC.continuous.integrable_of_hasCompactSupport hρc).mul_const _
  have hpt : ∀ y, mol d n y • (f (x - y) - f x)
      = f (x - y) * cx (mol d n) y - cx (mol d n) y * f x := by
    intro y
    simp only [cx, Complex.real_smul]
    ring
  rw [integral_congr_ae (Filter.Eventually.of_forall hpt), integral_sub hsw hint2,
    integral_mul_const, hcnv]
  have h1 : ∫ t, cx (mol d n) t = 1 := by
    simp only [cx]
    rw [integral_complex_ofReal, integral_mol]
    simp
  rw [h1, one_mul]
