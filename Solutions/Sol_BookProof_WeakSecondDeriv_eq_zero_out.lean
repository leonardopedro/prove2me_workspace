-- Generated from ChapterWeakSecondDerivative.lean — solution of BookProof.WeakSecondDeriv.eq_zero_out
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv




open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {g : ℝ → ℝ} {R : ℝ} (hsupp : tsupport g ⊆ Icc (-R) R)
    {x : ℝ} (hx : x ∉ Icc (-R) R) : g x = 0 := image_eq_zero_of_notMem_tsupport (fun h => hx (hsupp h))
