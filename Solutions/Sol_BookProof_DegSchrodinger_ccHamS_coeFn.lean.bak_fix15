-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.ccHamS_coeFn
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_DegSchrodinger_kinOpS_apply_eq
import Theorems.Thm_BookProof_DegSchrodinger_kinCcS_apply
import Theorems.Thm_BookProof_ScalaronEsa_mulCc_apply
import Theorems.Thm_BookProof_ScalaronEsa_opCc_apply
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (S : Finset (Fin d)) (f : ccSchwartz (Vd d)) :
    ((ccHamS W hW S (ccEquiv (Vd d) f) : L2d d) : Vd d → ℂ)
      =ᵐ[volume] fun x => -lapCS S ((f : 𝓢(Vd d, ℂ)) : Vd d → ℂ) x
        + ((W x : ℝ) : ℂ) * (f : 𝓢(Vd d, ℂ)) x := by

  have h1 : ccHamS W hW S (ccEquiv (Vd d) f)
      = (kinOpS S (f : 𝓢(Vd d, ℂ))).toLp 2 (volume : Measure (Vd d))
        + (mulCc W hW f).toLp 2 (volume : Measure (Vd d)) := by
    simp only [ccHamS, LinearMap.add_apply, kinCcS_apply, opCc_apply]
  rw [h1]
  filter_upwards [Lp.coeFn_add ((kinOpS S (f : 𝓢(Vd d, ℂ))).toLp 2 (volume : Measure (Vd d)))
      ((mulCc W hW f).toLp 2 (volume : Measure (Vd d))),
    (kinOpS S (f : 𝓢(Vd d, ℂ))).coeFn_toLp 2 (volume : Measure (Vd d)),
    (mulCc W hW f).coeFn_toLp 2 (volume : Measure (Vd d))] with z hz h2 h3
  rw [hz, Pi.add_apply, h2, h3, kinOpS_apply_eq, mulCc_apply]
