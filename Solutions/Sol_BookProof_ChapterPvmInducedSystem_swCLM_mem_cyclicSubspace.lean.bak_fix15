-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.swCLM_mem_cyclicSubspace
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
open BookProof.ChapterPvmInducedSystem



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (P : Pvm X H) (ψ : H) (f : Lp ℂ 2 (pvmMeasure P ψ)) :
    swCLM P ψ f ∈ cyclicSubspace P ψ := by

  refine Lp.induction (p := 2) (by simp)
    (fun f => swCLM P ψ f ∈ cyclicSubspace P ψ) ?_ ?_ ?_ f
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
    rw [hcsmul, map_smul, swCLM_indicator P ψ hF]
    exact Submodule.smul_mem _ _
      (Submodule.le_topologicalClosure _ (Submodule.subset_span ⟨F, hF, rfl⟩))
  · intro g h hg hh _ hPg hPh
    rw [map_add]
    exact Submodule.add_mem _ hPg hPh
  · exact IsClosed.preimage (swCLM P ψ).continuous
      (Submodule.isClosed_topologicalClosure _)
