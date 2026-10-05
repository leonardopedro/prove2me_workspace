-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.model_ae_ne_zero
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_resOp_injective
open BookProof.UnboundedSpectralModel



noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) {mu : Measure (spectrum ℂ (resOp T))}
  (V : Lp ℂ 2 mu →ₗᵢ[ℂ] H)
  (hV : ∀ u : Lp ℂ 2 mu, V (mulRep mu (coordFn (resOp T)) u) = resOp T (V u))

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure mu] : ∀ᵐ z ∂mu, z.1 ≠ 0 := by

  classical
  set s : Set (spectrum ℂ (resOp T)) := {z | z.1 = 0} with hsdef
  have hsm : MeasurableSet s :=
    continuous_subtype_val.measurable (measurableSet_singleton (0 : ℂ))
  have hzero : mu s = 0 := by
    by_contra hne
    set u : Lp ℂ 2 mu := indicatorConstLp 2 hsm (measure_ne_top mu s) (1 : ℂ) with hu
    have hZu : mulRep mu (coordFn (resOp T)) u = 0 := by
      refine Lp.ext ?_
      filter_upwards [mulRep_coeFn mu (coordFn (resOp T)) u,
        indicatorConstLp_coeFn (p := 2) (hs := hsm) (hμs := measure_ne_top mu s) (c := (1 : ℂ)),
        Lp.coeFn_zero ℂ 2 mu] with z h1 h2 h3
      rw [h1, h3, hu, h2]
      by_cases hz : z ∈ s
      · have : z.1 = 0 := hz
        simp [Set.indicator_of_mem hz, coordFn, this]
      · simp [Set.indicator_of_notMem hz]
    have hVu : V u = 0 := by
      have h := hV u
      rw [hZu, map_zero] at h
      have : resOp T (V u) = resOp T 0 := by simpa using h.symm
      exact resOp_injective T this
    have hnorm : ‖u‖ = 0 := by
      have := V.norm_map u
      rw [hVu] at this
      simpa using this.symm
    have hu0 : u = 0 := by simpa using hnorm
    have hnormu : ‖u‖ = (mu s).toReal ^ (1 / (2 : ℝ)) := by
      rw [hu, norm_indicatorConstLp (by norm_num) (by norm_num)]
      simp [MeasureTheory.measureReal_def]
    rw [hnorm] at hnormu
    have hpos : 0 < (mu s).toReal := by
      refine ENNReal.toReal_pos hne (measure_ne_top mu s)
    have : (0 : ℝ) < (mu s).toReal ^ (1 / (2 : ℝ)) := Real.rpow_pos_of_pos hpos _
    rw [← hnormu] at this
    exact absurd rfl (ne_of_gt this)
  refine (ae_iff).mpr ?_
  simpa [hsdef] using hzero
