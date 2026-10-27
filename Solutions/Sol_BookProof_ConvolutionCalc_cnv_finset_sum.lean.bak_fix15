-- Generated from ChapterConvolutionCalc.lean — solution of BookProof.ConvolutionCalc.cnv_finset_sum
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
open BookProof.ConvolutionCalc




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι) {u : Vd d → ℂ} {g : ι → Vd d → ℂ}
    (hu : LocallyIntegrable u (volume : Measure (Vd d)))
    (hg : ∀ i ∈ s, Continuous (g i)) (hgc : ∀ i ∈ s, HasCompactSupport (g i)) (x : Vd d) :
    cnv u (fun y => ∑ i ∈ s, g i y) x = ∑ i ∈ s, cnv u (g i) x := by

  classical
  have hint : ∀ i ∈ s, Integrable (fun y => u y * g i (x - y)) (volume : Measure (Vd d)) := by
    intro i hi
    exact (hgc i hi).convolutionExists_right (ContinuousLinearMap.mul ℝ ℂ) hu (hg i hi) x
  simp only [cnv_apply]
  rw [← MeasureTheory.integral_finset_sum s hint]
  refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
  simp [Finset.mul_sum]
