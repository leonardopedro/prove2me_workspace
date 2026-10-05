-- Generated from ChapterPvmCyclicUnitary.lean — solution of BookProof.ChapterPvmCyclicUnitary.swCLM_proj
import Mathlib
import Definitions.Def_ChapterPvmCyclicUnitary
import Theorems.Thm_BookProof_ChapterPvmCyclicUnitary_proj_indicatorConstLp
import Theorems.Thm_BookProof_ChapterParityMajoranaQuant_proj_add
open BookProof.ChapterPvmCyclicUnitary



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterMackeyQuasiInvariant

attribute [local instance] Lp.simpleFunc.module Lp.simpleFunc.normedSpace

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (P : Pvm X H) (ψ : H)
variable [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {E : Set X} (hE : MeasurableSet E) (f : Lp ℂ 2 (pvmMeasure P ψ)) :
    swCLM P ψ (proj (pvmMeasure P ψ) hE f) = P.p E (swCLM P ψ f) := by

  refine Lp.induction (p := 2) (by simp)
    (fun f => swCLM P ψ (proj (pvmMeasure P ψ) hE f) = P.p E (swCLM P ψ f)) ?_ ?_ ?_ f
  · intro c F hF hμF
    rw [Lp.simpleFunc.coe_indicatorConst]
    have hcsmul : indicatorConstLp 2 hF hμF.ne c
        = c • indicatorConstLp 2 hF (measure_ne_top (pvmMeasure P ψ) F) (1 : ℂ) := by
      refine Lp.ext ?_
      filter_upwards [indicatorConstLp_coeFn (μ := pvmMeasure P ψ) (p := 2) (s := F)
          (hs := hF) (hμs := hμF.ne) (c := c),
        Lp.coeFn_smul c (indicatorConstLp 2 hF (measure_ne_top (pvmMeasure P ψ) F) (1 : ℂ)),
        indicatorConstLp_coeFn (μ := pvmMeasure P ψ) (p := 2) (s := F)
          (hs := hF) (hμs := measure_ne_top (pvmMeasure P ψ) F) (c := (1 : ℂ))] with x e1 e2 e3
      simp only [Pi.smul_apply] at e2
      rw [e1, e2, e3]
      by_cases hx : x ∈ F <;> simp [hx]
    rw [hcsmul, proj_smul, map_smul, map_smul, proj_indicatorConstLp P ψ hE hF,
      swCLM_indicator P ψ (hE.inter hF), swCLM_indicator P ψ hF, map_smul, P.inter hE hF]
  · intro g h hg hh _ hPg hPh
    rw [proj_add, map_add, map_add, hPg, hPh, map_add]
  · exact isClosed_eq
      ((swCLM P ψ).continuous.comp (projL (pvmMeasure P ψ) hE).continuous)
      ((P.p E).continuous.comp (swCLM P ψ).continuous)
