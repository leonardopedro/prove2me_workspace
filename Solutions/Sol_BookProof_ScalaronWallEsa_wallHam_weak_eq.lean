import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterWeakSecondDerivative
-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.wallHam_weak_eq
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Theorems.Thm_BookProof_ScalaronWallEsa_kinOpR_apply
import Theorems.Thm_BookProof_ScalaronWallEsa_deriv_ofReal_comp
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
import Theorems.Thm_BookProof_StrichartzWave_integrable_conj_schwartz_mul
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
open BookProof.ScalaronWallEsa













open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ)
    (u : Lp ℂ 2 (volume : Measure ℝ))
    (hu : ∀ v : ccDomain ℝ,
      (inner ℂ (wallHam V hV v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    {g : ℝ → ℝ} (hg : IsTestFun g) :
    ∫ x, ((deriv (deriv g) x : ℝ) : ℂ) * u x
      = ∫ x, ((g x : ℝ) : ℂ) * ((((V x : ℝ) : ℂ) - z) * u x) := by

  set ψ : ccSchwartz ℝ := testCc hg with hψ
  have hψx : ∀ x, ((ψ : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x = ((g x : ℝ) : ℂ) := fun _ => rfl
  -- the kinetic part of the pairing
  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ)) (ccEquiv ℝ ψ)
      = schwartzEquiv ℝ (ψ : 𝓢(ℝ, ℂ)) := Subtype.ext rfl
  have hkin : kinCcR (ccEquiv ℝ ψ) = (kinOpR (ψ : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ) := by
    simp only [kinCcR, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
  have hd2 : deriv (deriv ((ψ : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) = fun x => ((deriv (deriv g) x : ℝ) : ℂ) := by
    have he : ((ψ : 𝓢(ℝ, ℂ)) : ℝ → ℂ) = fun y => ((g y : ℝ) : ℂ) := funext hψx
    rw [he, deriv_ofReal_comp hg.differentiable, deriv_ofReal_comp hg.deriv.differentiable]
  have hkinint : (inner ℂ (kinCcR (ccEquiv ℝ ψ)) u : ℂ)
      = -∫ x, ((deriv (deriv g) x : ℝ) : ℂ) * u x := by
    rw [hkin, inner_toLp_left, ← integral_neg]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    change (starRingEnd ℂ) ((kinOpR (ψ : 𝓢(ℝ, ℂ))) x) * u x
      = -(((deriv (deriv g) x : ℝ) : ℂ) * u x)
    rw [kinOpR_apply, hd2]
    simp
  -- the potential part of the pairing
  have hpot : (inner ℂ (opCc V hV (ccEquiv ℝ ψ)) u : ℂ)
      = ∫ x, ((V x : ℝ) : ℂ) * (((g x : ℝ) : ℂ) * u x) := by
    rw [opCc_apply, inner_toLp_left]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [mulCc_apply, hψx, map_mul, Complex.conj_ofReal]
    ring
  have hplain : (inner ℂ ((ccEquiv ℝ ψ : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) u : ℂ)
      = ∫ x, ((g x : ℝ) : ℂ) * u x := by
    rw [ccEquiv_coe, inner_toLp_left]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp [hψx]
  -- integrability
  have hint1 : Integrable (fun x => ((g x : ℝ) : ℂ) * u x) (volume : Measure ℝ) := by
    have := integrable_conj_schwartz_mul (ψ : 𝓢(ℝ, ℂ)) u
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp [hψx]
  have hint2 : Integrable (fun x => ((V x : ℝ) : ℂ) * (((g x : ℝ) : ℂ) * u x))
      (volume : Measure ℝ) := by
    have := integrable_conj_schwartz_mul (mulCc V hV ψ) u
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [mulCc_apply, hψx, map_mul, Complex.conj_ofReal]
    ring
  have h1 := hu (ccEquiv ℝ ψ)
  simp only [wallHam, LinearMap.add_apply, inner_add_left, hkinint, hpot, hplain] at h1
  have hsplit : ∫ x, ((g x : ℝ) : ℂ) * ((((V x : ℝ) : ℂ) - z) * u x)
      = (∫ x, ((V x : ℝ) : ℂ) * (((g x : ℝ) : ℂ) * u x))
        - z * ∫ x, ((g x : ℝ) : ℂ) * u x := by
    rw [← MeasureTheory.integral_const_mul, ← integral_sub hint2 (hint1.const_mul z)]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  rw [hsplit]
  linear_combination -h1
