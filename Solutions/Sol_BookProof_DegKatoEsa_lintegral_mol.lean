-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.lintegral_mol
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_contDiff_mol
import Theorems.Thm_BookProof_DegKatoEsa_hasCompactSupport_mol
import Theorems.Thm_BookProof_DegKatoEsa_mol_nonneg
import Theorems.Thm_BookProof_DegKatoEsa_integral_mol
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
theorem solution (n : ℕ) : ∫⁻ y, ENNReal.ofReal (mol d n y) = 1 := by

  have hint : Integrable (mol d n) (volume : Measure (Vd d)) :=
    (contDiff_mol n).continuous.integrable_of_hasCompactSupport (hasCompactSupport_mol n)
  rw [← ofReal_integral_eq_lintegral_ofReal hint
    (Filter.Eventually.of_forall fun y => mol_nonneg n y), integral_mol]
  simp
