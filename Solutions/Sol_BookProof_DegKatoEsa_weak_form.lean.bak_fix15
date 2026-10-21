-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.weak_form
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_inner_ae_eq
import Theorems.Thm_BookProof_DegSchrodinger_ccHamS_coeFn
import Theorems.Thm_BookProof_ScalaronEsa_ccEquiv_coe
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
    {φ : Vd d → ℂ} (hφ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) φ) (hφc : HasCompactSupport φ) :
    ∫ y, (starRingEnd ℂ) (-lapCS S φ y + ((W y : ℝ) : ℂ) * φ y) * (u : Vd d → ℂ) y
      = z * ∫ y, (starRingEnd ℂ) (φ y) * (u : Vd d → ℂ) y := by

  have h := hu (ccOf hφ hφc)
  rw [show (ccOf hφ hφc) = ccEquiv (Vd d) ⟨hφc.toSchwartzMap hφ, hφc⟩ from rfl] at h
  rw [inner_ae_eq _ _ (ccHamS_coeFn W hWs S ⟨hφc.toSchwartzMap hφ, hφc⟩) u, ccEquiv_coe,
    inner_ae_eq _ _ ((hφc.toSchwartzMap hφ).coeFn_toLp 2 (volume : Measure (Vd d))) u] at h
  exact h
