-- Generated from ChapterMehlerOrthogonalInvariance.lean — solution of BookProof.ChapterMehlerOrthogonalInvariance.coordinateTailMeasure_map_headRotation
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
import Theorems.Thm_BookProof_ChapterMehlerOrthogonalInvariance_gaussianHead_map_orthogonal
import Theorems.Thm_BookProof_ChapterSolovayCoordinates_tailSplitEquiv_map
open BookProof.ChapterMehlerOrthogonalInvariance



open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution {k : ℕ} (O : Matrix (Fin k) (Fin k) ℝ)
    (hO : Oᵀ * O = 1) :
    coordinateTailMeasure.map (headRotation k O) = coordinateTailMeasure := by

  have hmeasO : Measurable fun h : Fin k → ℝ => O *ᵥ h := by fun_prop
  have hprod : Measurable (Prod.map (fun h : Fin k → ℝ => O *ᵥ h) (id : CoordinateTail → _)) :=
    (hmeasO.comp measurable_fst).prodMk (measurable_id.comp measurable_snd)
  have hab : Measurable ((tailSplitEquiv k).symm ∘ Prod.map (fun h : Fin k → ℝ => O *ᵥ h) id) :=
    (tailSplitEquiv k).symm.measurable.comp hprod
  unfold headRotation
  rw [← Function.comp_def, ← Function.comp_def, ← Function.comp_assoc,
    ← Measure.map_map hab (tailSplitEquiv k).measurable, tailSplitEquiv_map,
    ← Measure.map_map (tailSplitEquiv k).symm.measurable hprod,
    ← Measure.map_prod_map _ _ hmeasO measurable_id, gaussianHead_map_orthogonal O hO,
    Measure.map_id, ← tailSplitEquiv_map,
    Measure.map_map (tailSplitEquiv k).symm.measurable (tailSplitEquiv k).measurable]
  simp
