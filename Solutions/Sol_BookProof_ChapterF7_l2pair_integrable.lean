-- Generated from ChapterF7.lean — solution of BookProof.ChapterF7.l2pair_integrable
import Mathlib
import Definitions.Def_ChapterF7
open BookProof.ChapterF7



open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f g : 𝓢(ℝ, ℂ)) :
    Integrable (fun x => (starRingEnd ℂ) (f x) * g x) volume := by

  obtain ⟨C, _, hC⟩ := f.decay 0 0
  refine (g.integrable (μ := volume)).bdd_mul (c := C)
    ((Complex.continuous_conj.comp f.continuous).aestronglyMeasurable) ?_
  exact Filter.Eventually.of_forall (fun x => by simpa using hC x)
