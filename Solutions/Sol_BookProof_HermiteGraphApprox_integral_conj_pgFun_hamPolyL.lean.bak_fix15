-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.integral_conj_pgFun_hamPolyL
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_pgFun_add_apply
import Theorems.Thm_BookProof_HermiteGraphApprox_integral_conj_dd_mul
import Theorems.Thm_BookProof_ConvolutionCalc_hasCompactSupport_dcoord
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_lapCS_pgFun
import Theorems.Thm_BookProof_DegSchrodinger_pgFun_mul_polyW
import Theorems.Thm_BookProof_HermiteLadder_hamPolyL_apply
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_dcoord
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
theorem solution (S : Finset (Fin d)) {q : MvPolynomial (Fin d) ℂ}
    (hq : RealCoeff q) (p : MvPolynomial (Fin d) ℂ) {g : Vd d → ℂ}
    (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g) (hgc : HasCompactSupport g) :
    ∫ x, (starRingEnd ℂ) (pgFun (hamPolyL S q p) x) * g x
      = ∫ x, (starRingEnd ℂ) (pgFun p x) * Lfun S (polyW q) g x := by

  have hf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (pgFun p) := contDiff_pgFun p
  have hpt : ∀ x, pgFun (hamPolyL S q p) x = -lapCS S (pgFun p) x
      + ((polyW q x : ℝ) : ℂ) * pgFun p x := by
    intro x
    rw [hamPolyL_apply, pgFun_add_apply, pgFun_mul_polyW hq, lapCS_pgFun, neg_neg]
  have hI : ∀ j, Integrable (fun x => (starRingEnd ℂ) (dcoord j (dcoord j (pgFun p)) x) * g x)
      (volume : Measure (Vd d)) := fun j =>
    ((Complex.continuous_conj.comp (contDiff_dcoord (contDiff_dcoord hf j) j).continuous).mul
      hg.continuous).integrable_of_hasCompactSupport hgc.mul_left
  have hI' : ∀ j, Integrable (fun x => (starRingEnd ℂ) (pgFun p x) * dcoord j (dcoord j g) x)
      (volume : Measure (Vd d)) := fun j =>
    ((Complex.continuous_conj.comp hf.continuous).mul
      (contDiff_dcoord (contDiff_dcoord hg j) j).continuous).integrable_of_hasCompactSupport
      (hasCompactSupport_dcoord (hasCompactSupport_dcoord hgc j) j).mul_left
  have hW : Integrable (fun x => (starRingEnd ℂ) (pgFun p x) * (((polyW q x : ℝ) : ℂ) * g x))
      (volume : Measure (Vd d)) :=
    ((Complex.continuous_conj.comp hf.continuous).mul
      ((Complex.continuous_ofReal.comp (continuous_polyW q)).mul
        hg.continuous)).integrable_of_hasCompactSupport hgc.mul_left.mul_left
  have hlap : ∫ x, (starRingEnd ℂ) (lapCS S (pgFun p) x) * g x
      = ∫ x, (starRingEnd ℂ) (pgFun p x) * lapCS S g x := by
    simp only [lapCS, map_sum, Finset.sum_mul, Finset.mul_sum]
    rw [integral_finset_sum S fun j _ => hI j, integral_finset_sum S fun j _ => hI' j]
    exact Finset.sum_congr rfl fun j _ => integral_conj_dd_mul hf hg hgc j
  have hLI : Integrable (fun x => (starRingEnd ℂ) (lapCS S (pgFun p) x) * g x)
      (volume : Measure (Vd d)) := by
    simp only [lapCS, map_sum, Finset.sum_mul]
    exact integrable_finset_sum S fun j _ => hI j
  have hRI : Integrable (fun x => (starRingEnd ℂ) (pgFun p x) * lapCS S g x)
      (volume : Measure (Vd d)) := by
    simp only [lapCS, Finset.mul_sum]
    exact integrable_finset_sum S fun j _ => hI' j
  have e1 : ∀ x, (starRingEnd ℂ) (pgFun (hamPolyL S q p) x) * g x
      = (starRingEnd ℂ) (pgFun p x) * (((polyW q x : ℝ) : ℂ) * g x)
        - (starRingEnd ℂ) (lapCS S (pgFun p) x) * g x := by
    intro x
    rw [hpt x]
    simp only [map_add, map_neg, map_mul, Complex.conj_ofReal]
    ring
  have e2 : ∀ x, (starRingEnd ℂ) (pgFun p x) * Lfun S (polyW q) g x
      = (starRingEnd ℂ) (pgFun p x) * (((polyW q x : ℝ) : ℂ) * g x)
        - (starRingEnd ℂ) (pgFun p x) * lapCS S g x := by
    intro x
    simp only [Lfun]
    ring
  rw [integral_congr_ae (Filter.Eventually.of_forall e1),
    integral_congr_ae (Filter.Eventually.of_forall e2), integral_sub hW hLI,
    integral_sub hW hRI, hlap]
