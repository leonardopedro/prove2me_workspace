-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.mollified_identity
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_weak_form
import Theorems.Thm_BookProof_ConvolutionCalc_hasCompactSupport_dcoord
import Theorems.Thm_BookProof_ConvolutionCalc_hasCompactSupport_finsetSum
import Theorems.Thm_BookProof_ConvolutionCalc_integrable_cnv_integrand
import Theorems.Thm_BookProof_ConvolutionCalc_lapCS_cnv
import Theorems.Thm_BookProof_ConvolutionCalc_lapCS_reflect
import Theorems.Thm_BookProof_DegEnergy_contDiff_cx
import Theorems.Thm_BookProof_DegEnergy_hasCompactSupport_cx
import Theorems.Thm_BookProof_DegEnergy_lapCS_cx_conj
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_dcoord
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
theorem solution (W : Vd d → ℝ) (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (S : Finset (Fin d)) {z : ℂ} {u : L2d d}
    (hu : ∀ v : ccDomain (Vd d), (inner ℂ (ccHamS W hWs S v) u : ℂ)
      = z * inner ℂ ((v : L2d d)) u)
    {ρ : Vd d → ℝ} (hρ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) ρ) (hρc : HasCompactSupport ρ)
    (x : Vd d) :
    lapCS S (cnv ((u : Vd d → ℂ)) (cx ρ)) x
      = cnv (fun y => ((W y : ℝ) : ℂ) * (u : Vd d → ℂ) y) (cx ρ) x
        - z * cnv ((u : Vd d → ℂ)) (cx ρ) x := by

  have hUloc : LocallyIntegrable ((u : Vd d → ℂ)) (volume : Measure (Vd d)) :=
    (Lp.memLp u).locallyIntegrable one_le_two
  have hWUloc : LocallyIntegrable (fun y => ((W y : ℝ) : ℂ) * (u : Vd d → ℂ) y)
      (volume : Measure (Vd d)) := by
    have h1 : LocallyIntegrable (fun y => (u : Vd d → ℂ) y * ((W y : ℝ) : ℂ))
        (volume : Measure (Vd d)) := by
      rw [← locallyIntegrableOn_univ] at hUloc ⊢
      exact hUloc.mul_continuousOn
        (Complex.continuous_ofReal.comp hWs.continuous).continuousOn
        (IsClosed.isLocallyClosed isClosed_univ)
    have heq : (fun y => ((W y : ℝ) : ℂ) * (u : Vd d → ℂ) y)
        = fun y => (u : Vd d → ℂ) y * ((W y : ℝ) : ℂ) := by
      funext y
      ring
    rw [heq]
    exact h1
  have hρC : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cx ρ) := contDiff_cx hρ
  have hρCc : HasCompactSupport (cx ρ) := hasCompactSupport_cx hρc
  have hLρ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (lapCS S (cx ρ)) :=
    ContDiff.sum fun j _ => contDiff_dcoord (contDiff_dcoord hρC j) j
  have hLρc : HasCompactSupport (lapCS S (cx ρ)) :=
    hasCompactSupport_finsetSum S fun j _ =>
      hasCompactSupport_dcoord (hasCompactSupport_dcoord hρCc j) j
  -- the test function
  have hφ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun y => cx ρ (x - y)) :=
    hρC.comp (contDiff_const.sub contDiff_id)
  have hφc : HasCompactSupport (fun y => cx ρ (x - y)) :=
    hρCc.comp_homeomorph (Homeomorph.subLeft x)
  have hw := weak_form W hWs S hu hφ hφc
  have hI1 : Integrable (fun y => (u : Vd d → ℂ) y * lapCS S (cx ρ) (x - y))
      (volume : Measure (Vd d)) := integrable_cnv_integrand hUloc hLρ.continuous hLρc x
  have hI2 : Integrable (fun y => (((W y : ℝ) : ℂ) * (u : Vd d → ℂ) y) * cx ρ (x - y))
      (volume : Measure (Vd d)) := integrable_cnv_integrand hWUloc hρC.continuous hρCc x
  -- rewrite the two integrands
  have hpt : ∀ y : Vd d, (starRingEnd ℂ) (-lapCS S (fun y => cx ρ (x - y)) y
        + ((W y : ℝ) : ℂ) * cx ρ (x - y)) * (u : Vd d → ℂ) y
      = (((W y : ℝ) : ℂ) * (u : Vd d → ℂ) y) * cx ρ (x - y)
        - (u : Vd d → ℂ) y * lapCS S (cx ρ) (x - y) := by
    intro y
    rw [lapCS_reflect hρC x S y]
    simp only [map_add, map_neg, map_mul, Complex.conj_ofReal, lapCS_cx_conj hρ S (x - y)]
    have hcxr : (starRingEnd ℂ) (cx ρ (x - y)) = cx ρ (x - y) := by simp [cx]
    rw [hcxr]
    ring
  have hpt2 : ∀ y : Vd d, (starRingEnd ℂ) (cx ρ (x - y)) * (u : Vd d → ℂ) y
      = (u : Vd d → ℂ) y * cx ρ (x - y) := by
    intro y
    have hcxr : (starRingEnd ℂ) (cx ρ (x - y)) = cx ρ (x - y) := by simp [cx]
    rw [hcxr]
    ring
  rw [integral_congr_ae (Filter.Eventually.of_forall hpt),
    integral_congr_ae (Filter.Eventually.of_forall hpt2), integral_sub hI2 hI1] at hw
  have hcnv : cnv ((u : Vd d → ℂ)) (lapCS S (cx ρ)) x = lapCS S (cnv ((u : Vd d → ℂ)) (cx ρ)) x :=
    (lapCS_cnv hUloc hρC hρCc S x).symm
  have hw' : cnv (fun y => ((W y : ℝ) : ℂ) * (u : Vd d → ℂ) y) (cx ρ) x
      - cnv ((u : Vd d → ℂ)) (lapCS S (cx ρ)) x
      = z * cnv ((u : Vd d → ℂ)) (cx ρ) x := hw
  rw [hcnv] at hw'
  linear_combination -hw'
