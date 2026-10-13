-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.integral_conj_dd_mul
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_ConvolutionCalc_hasCompactSupport_dcoord
import Theorems.Thm_BookProof_DegEnergy_dcoord_conj
import Theorems.Thm_BookProof_DegEnergy_integral_dcoord_mul
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_dcoord
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {f g : Vd d → ℂ} (hf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) f)
    (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g) (hgc : HasCompactSupport g) (j : Fin d) :
    ∫ x, (starRingEnd ℂ) (dcoord j (dcoord j f) x) * g x
      = ∫ x, (starRingEnd ℂ) (f x) * dcoord j (dcoord j g) x := by

  have hdf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (dcoord j f) := contDiff_dcoord hf j
  have hcf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun y => (starRingEnd ℂ) (f y)) :=
    Complex.conjLIE.toLinearIsometry.toContinuousLinearMap.contDiff.comp hf
  have hcdf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun y => (starRingEnd ℂ) (dcoord j f y)) :=
    Complex.conjLIE.toLinearIsometry.toContinuousLinearMap.contDiff.comp hdf
  have h1 : ∫ x, (starRingEnd ℂ) (dcoord j (dcoord j f) x) * g x
      = ∫ x, g x * dcoord j (fun y => (starRingEnd ℂ) (dcoord j f y)) x := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only
    rw [dcoord_conj hdf j x, mul_comm]
  have h2 : ∫ x, dcoord j g x * (starRingEnd ℂ) (dcoord j f x)
      = ∫ x, dcoord j g x * dcoord j (fun y => (starRingEnd ℂ) (f y)) x := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only
    rw [dcoord_conj hf j x]
  rw [h1, integral_dcoord_mul hg hgc hcdf j, h2,
    integral_dcoord_mul (contDiff_dcoord hg j) (hasCompactSupport_dcoord hgc j) hcf j, neg_neg]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only
  ring
