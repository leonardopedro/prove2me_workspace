import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStrichartzWave
-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.integral_conj_mul_smoothPotential_sub_eq_zero
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Theorems.Thm_BookProof_ScalaronEsa_ccEquiv_coe
import Theorems.Thm_BookProof_ScalaronEsa_opCc_apply
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
import Theorems.Thm_BookProof_StrichartzWave_integrable_conj_schwartz_mul
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
    (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) (z : ℂ)
    (u : Lp ℂ 2 (volume : Measure E))
    (hu : ∀ v : ccDomain E,
      (inner ℂ (opCc W hW v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (ψ : ccSchwartz E) :
    ∫ x, (starRingEnd ℂ) ((ψ : 𝓢(E, ℂ)) x) * (((W x : ℝ) : ℂ) - z) * (u x) = 0 := by

  have h1 := hu (ccEquiv E ψ)
  rw [opCc_apply, ccEquiv_coe, inner_toLp_left, inner_toLp_left] at h1
  have hL : ∫ x, (starRingEnd ℂ) ((mulCc W hW ψ) x) * (u x)
      = ∫ x, ((W x : ℝ) : ℂ) * ((starRingEnd ℂ) ((ψ : 𝓢(E, ℂ)) x) * (u x)) := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [mulCc_apply, map_mul, Complex.conj_ofReal]
    ring
  rw [hL] at h1
  have hint1 : Integrable (fun x => (starRingEnd ℂ) ((ψ : 𝓢(E, ℂ)) x) * (u x))
      (volume : Measure E) := integrable_conj_schwartz_mul _ u
  have hint2 : Integrable
      (fun x => ((W x : ℝ) : ℂ) * ((starRingEnd ℂ) ((ψ : 𝓢(E, ℂ)) x) * (u x)))
      (volume : Measure E) := by
    have := integrable_conj_schwartz_mul (mulCc W hW ψ) u
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [mulCc_apply, map_mul, Complex.conj_ofReal]
    ring
  have hcomb : ∫ x, (((W x : ℝ) : ℂ) * ((starRingEnd ℂ) ((ψ : 𝓢(E, ℂ)) x) * (u x))
      - z * ((starRingEnd ℂ) ((ψ : 𝓢(E, ℂ)) x) * (u x))) = 0 := by
    rw [integral_sub hint2 (hint1.const_mul z), MeasureTheory.integral_const_mul, h1]
    ring
  rw [← hcomb]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  ring
