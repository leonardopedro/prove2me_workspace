-- Generated from ChapterSeparableL2Model.lean — solution of BookProof.ChapterSeparableL2Model.separable_Lp_realizes_standard_type
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
import Theorems.Thm_BookProof_ChapterSeparableL2Model_exists_countable_dense_continuous
import Theorems.Thm_BookProof_ChapterSeparableL2Model_measurable_coordMap
import Theorems.Thm_BookProof_ChapterStandardBorelClassification_standardBorel_classification_list
open BookProof.ChapterSeparableL2Model



noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterAbelianDirectSum BookProof.ChapterLinftyMultiplication
open BookProof.ChapterStandardBorelClassification

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [MeasurableSpace Y]
  [BorelSpace Y] (D : Set C(Y, ℂ)) [Countable D]
variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsProbabilityMeasure mu] [mu.WeaklyRegular]

set_option maxHeartbeats 1000000 in
theorem solution [SeparableSpace (Lp ℂ 2 mu)] :
    ∃ (Z : Type u) (_ : MeasurableSpace Z) (_ : StandardBorelSpace Z)
      (_ : MeasurableSingletonClass Z) (Phi : Y → Z) (hPhi : Measurable Phi),
      ∃ _ : IsProbabilityMeasure (Measure.map Phi mu),
        RealizesStandardType (Measure.map Phi mu) ∧
        ∃ U : Lp ℂ 2 (Measure.map Phi mu) ≃ₗᵢ[ℂ] Lp ℂ 2 mu,
          ∀ (g : Z → ℂ) (hg : MemLp g ⊤ (Measure.map Phi mu))
            (v : Lp ℂ 2 (Measure.map Phi mu)),
            U (multOp g hg v)
              = multOp (fun y => g (Phi y)) (hg.comp_measurePreserving ⟨hPhi, rfl⟩) (U v) := by

  classical
  obtain ⟨D, hDc, hDdense⟩ := exists_countable_dense_continuous mu
  haveI : Countable D := hDc.to_subtype
  haveI hborel : BorelSpace (∀ _ : D, ℂ) := Pi.borelSpace
  set Phi : Y → (D → ℂ) := coordMap D with hPhidef
  have hPhi : Measurable Phi := measurable_coordMap D
  have hmp : MeasurePreserving Phi mu (Measure.map Phi mu) := ⟨hPhi, rfl⟩
  haveI hprob : IsProbabilityMeasure (Measure.map Phi mu) :=
    Measure.isProbabilityMeasure_map hPhi.aemeasurable
  set L : Lp ℂ 2 (Measure.map Phi mu) →ₗᵢ[ℂ] Lp ℂ 2 mu :=
    Lp.compMeasurePreservingₗᵢ ℂ Phi hmp with hLdef
  have hLcoe : ∀ w : Lp ℂ 2 (Measure.map Phi mu),
      ((L w : Lp ℂ 2 mu) : Y → ℂ) =ᵐ[mu] fun y => (w : (D → ℂ) → ℂ) (Phi y) :=
    fun w => Lp.coeFn_compMeasurePreserving w hmp
  -- every member of the dense family is in the range of `L`, via its coordinate
  have hcoord : ∀ d : D, ∃ w : Lp ℂ 2 (Measure.map Phi mu),
      L w = ContinuousMap.toLp 2 mu ℂ (d : C(Y, ℂ)) := by
    intro d
    have hcontd : Continuous fun z : D → ℂ => z d := continuous_apply d
    have hcomp : (fun z : D → ℂ => z d) ∘ Phi = fun y => (d : C(Y, ℂ)) y := rfl
    have hmemY : MemLp (fun y => (d : C(Y, ℂ)) y) 2 mu :=
      (Lp.memLp (ContinuousMap.toLp 2 mu ℂ (d : C(Y, ℂ)))).ae_eq
        (ContinuousMap.coeFn_toLp mu (d : C(Y, ℂ)))
    have hmem : MemLp (fun z : D → ℂ => z d) 2 (Measure.map Phi mu) := by
      refine (memLp_map_measure_iff ?_ hPhi.aemeasurable).2 ?_
      · exact hcontd.aestronglyMeasurable
      · rw [hcomp]; exact hmemY
    refine ⟨hmem.toLp _, ?_⟩
    refine Lp.ext ?_
    have h1 := hLcoe (hmem.toLp _)
    have h2 := hmp.quasiMeasurePreserving.ae_eq_comp hmem.coeFn_toLp
    have h3 := ContinuousMap.coeFn_toLp (p := 2) (𝕜 := ℂ) mu (d : C(Y, ℂ))
    filter_upwards [h1, h2, h3] with y hy1 hy2 hy3
    simp only [Function.comp_apply] at hy1 hy2
    rw [hy1, hy2, hy3]
    rfl
  -- so the range of `L`, closed because `L` is an isometry of complete spaces, is
  -- everything
  have hsurj : Function.Surjective L := by
    have hclosed : IsClosed (Set.range L) :=
      (L.isometry.isClosedEmbedding).isClosed_range
    have hsub : (fun f : C(Y, ℂ) => ContinuousMap.toLp 2 mu ℂ f) '' D ⊆ Set.range L := by
      rintro _ ⟨f, hf, rfl⟩
      obtain ⟨w, hw⟩ := hcoord ⟨f, hf⟩
      exact ⟨w, hw⟩
    have hdenseR : Dense (Set.range L) := hDdense.mono hsub
    have : Set.range L = Set.univ := by
      rw [← hclosed.closure_eq, hdenseR.closure_eq]
    intro u
    have : u ∈ Set.range L := this ▸ Set.mem_univ u
    exact this
  refine ⟨D → ℂ, inferInstance, inferInstance, inferInstance, Phi, hPhi, hprob,
    standardBorel_classification_list _, LinearIsometryEquiv.ofSurjective L hsurj, ?_⟩
  intro g hg v
  refine Lp.ext ?_
  have h1 := hLcoe (multOp g hg v)
  have h2 := hmp.quasiMeasurePreserving.ae_eq_comp
    (multOp_coeFn (μ := Measure.map Phi mu) g hg v)
  have h3 := multOp_coeFn (μ := mu) (fun y => g (Phi y))
    (hg.comp_measurePreserving hmp) (L v)
  have h4 := hLcoe v
  filter_upwards [h1, h2, h3, h4] with y hy1 hy2 hy3 hy4
  simp only [Function.comp_apply] at hy1 hy2 hy4
  simp only [LinearIsometryEquiv.coe_ofSurjective]
  rw [hy1, hy2, hy3, hy4]
