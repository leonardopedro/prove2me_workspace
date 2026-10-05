-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.isL2Ode_conj
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {V : ℝ → ℝ} {z : ℂ} {W : ℝ → ℂ} (h : IsL2Ode V z W) :
    IsL2Ode V ((starRingEnd ℂ) z) (fun x => (starRingEnd ℂ) (W x)) := by

  obtain ⟨W', hW, hW', hmem⟩ := h
  refine ⟨fun x => (starRingEnd ℂ) (W' x), fun x => (hW x).star, fun x => ?_, ?_⟩
  · have h2 := (hW' x).star
    have hval : (starRingEnd ℂ) ((((V x : ℝ) : ℂ) - z) * W x)
        = (((V x : ℝ) : ℂ) - (starRingEnd ℂ) z) * (starRingEnd ℂ) (W x) := by
      simp [map_mul, map_sub, Complex.conj_ofReal]
    rw [← hval]
    exact h2
  · exact hmem.congr_norm
      (Complex.continuous_conj.comp_aestronglyMeasurable hmem.aestronglyMeasurable)
      (Filter.Eventually.of_forall fun x => (Complex.norm_conj (W x)).symm)
