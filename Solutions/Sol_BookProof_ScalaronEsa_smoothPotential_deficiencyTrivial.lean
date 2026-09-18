import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStrichartzWave
-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.smoothPotential_deficiencyTrivial
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Theorems.Thm_BookProof_ScalaronEsa_integral_conj_mul_smoothPotential_sub_eq_zero
open BookProof.ScalaronEsa



open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (W : E → ℝ)
    (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (ccDomain E) (opCc W hW) z := by

  intro u hu
  have hz1 : ∀ x : E, ((W x : ℝ) : ℂ) - (starRingEnd ℂ) z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have hz2 : ∀ x : E, ((W x : ℝ) : ℂ) - z ≠ 0 := by
    intro x hx
    exact hz (by simpa using congrArg Complex.im hx)
  have main : ∀ χ : E → ℝ, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ → HasCompactSupport χ →
      ∫ x, χ x • (u x) = 0 := by
    intro χ hχ hχc
    have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
        (fun x => (χ x : ℂ) * (((W x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine (Complex.ofRealCLM.contDiff.comp hχ).mul (ContDiff.inv ?_ hz1)
      exact (Complex.ofRealCLM.contDiff.comp hW).sub contDiff_const
    have hsupp : HasCompactSupport
        (fun x => (χ x : ℂ) * (((W x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹) := by
      refine HasCompactSupport.mul_right ?_
      simpa using hχc.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)
    set ψ : ccSchwartz E := ⟨hsupp.toSchwartzMap hsmooth, hsupp⟩ with hψ
    have hψx : ∀ x, (ψ : 𝓢(E, ℂ)) x
        = (χ x : ℂ) * (((W x : ℝ) : ℂ) - (starRingEnd ℂ) z)⁻¹ := fun _ => rfl
    have key := integral_conj_mul_smoothPotential_sub_eq_zero W hW z u hu ψ
    rw [← key]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    have hc : (starRingEnd ℂ) ((ψ : 𝓢(E, ℂ)) x) * (((W x : ℝ) : ℂ) - z) = (χ x : ℂ) := by
      rw [hψx x]
      simp only [map_mul, map_inv₀, map_sub, Complex.conj_ofReal, Complex.conj_conj]
      field_simp
      exact mul_div_cancel_right₀ _ (hz2 x)
    change χ x • (u x) = (starRingEnd ℂ) ((ψ : 𝓢(E, ℂ)) x) * (((W x : ℝ) : ℂ) - z) * (u x)
    rw [Complex.real_smul, ← hc]
  have hloc : LocallyIntegrable (fun x => (u x : ℂ)) (volume : Measure E) :=
    (Lp.memLp u).locallyIntegrable (by norm_num)
  have hae : ∀ᵐ x ∂(volume : Measure E), (u x : ℂ) = 0 :=
    ae_eq_zero_of_integral_contDiff_smul_eq_zero hloc (fun χ hχ hχc => main χ hχ hχc)
  exact Lp.eq_zero_iff_ae_eq_zero.mpr hae
