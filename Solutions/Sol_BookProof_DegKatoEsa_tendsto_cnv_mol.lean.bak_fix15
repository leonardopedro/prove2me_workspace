-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.tendsto_cnv_mol
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_contDiff_mol
import Theorems.Thm_BookProof_DegKatoEsa_mol_nonneg
import Theorems.Thm_BookProof_DegKatoEsa_norm_lt_of_mol_ne_zero
import Theorems.Thm_BookProof_DegKatoEsa_lintegral_mol
import Theorems.Thm_BookProof_DegKatoEsa_integral_mol_smul_sub
import Theorems.Thm_BookProof_MollifierL2_tendsto_mollify_L2
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
theorem solution {f : Vd d → ℂ} (hf : StronglyMeasurable f)
    (hf2 : MemLp f 2 (volume : Measure (Vd d))) :
    Tendsto (fun n : ℕ => eLpNorm (fun x => cnv f (cx (mol d n)) x - f x) 2 volume) atTop
      (𝓝 0) := by

  have hloc : LocallyIntegrable f (volume : Measure (Vd d)) := hf2.locallyIntegrable one_le_two
  have h := tendsto_mollify_L2 (μ := (volume : Measure (Vd d))) (l := atTop) f hf hf2
    (fun n => mol d n) (fun n : ℕ => 1 / ((n : ℝ) + 1)) (fun n y => mol_nonneg n y)
    (fun n => (contDiff_mol n).continuous.measurable) (fun n => lintegral_mol n)
    (fun n y hy => norm_lt_of_mol_ne_zero hy) tendsto_one_div_add_atTop_nhds_zero_nat
  refine h.congr fun n => ?_
  congr 1
  funext x
  exact integral_mol_smul_sub hloc n x
